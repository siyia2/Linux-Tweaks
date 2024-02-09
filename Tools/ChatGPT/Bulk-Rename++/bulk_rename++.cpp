#include <iostream>
#include <string>
#include <filesystem>
#include <algorithm>
#include <vector>
#include <thread>
#include <mutex>
#include <readline/readline.h>
#include <readline/history.h>
#include <unistd.h>
#include <chrono> // Include chrono for time measurement

namespace fs = std::filesystem;

bool verbose_enabled = false; // Verbose mode disabled by default

std::mutex cout_mutex;  // Mutex to protect std::cout
std::mutex input_mutex;   // Mutex to protect input operations

char* safe_readline(const char* prompt) {
    std::lock_guard<std::mutex> lock(input_mutex);
    return readline(prompt);
}

void print_message(const std::string& message) {
    if (verbose_enabled) {
        std::lock_guard<std::mutex> lock(cout_mutex);
        std::cout << message << std::endl;
    }
}

void print_error(const std::string& error) {
    std::lock_guard<std::mutex> lock(cout_mutex);
    std::cerr << error << std::endl;
}

void print_help() {
    std::cout << "Usage: rename [OPTIONS] [PATHS]\n"
              << "Renames all files and folders under the specified path(s).\n"
              << "\n"
              << "Options:\n"
              << "  -h, --help           Print this message and exit\n"
              << "  -c  [MODE]           Set the case conversion mode (lower/upper/reverse)\n"
              << "  -cp [MODE]           Rename parent directories too (works only if input is not file)(lower/upper/reverse)\n"
              << "  -v, --verbose        Enable verbose mode\n"
              << "\n"
              << "Examples:\n"
              << "  bulk_rename++ /path/to/folder1 /path/to/folder2 -c lower\n"
              << "  bulk_rename++ /path/to/folder -v -cp upper\n"
              << "  bulk_rename++ /path/to/folder -cp upper\n";
}

void rename_item(const fs::path& item_path, const std::string& case_input, bool is_directory, bool verbose, int& files_count, int& dirs_count) {
    std::string name = item_path.filename().string();
    std::string new_name;
    new_name.resize(name.size()); // Resize new_name

    std::transform(name.begin(), name.end(), new_name.begin(), [case_input](unsigned char c) -> unsigned char {
        if (case_input == "lower") {
            return std::tolower(c);
        } else if (case_input == "upper") {
            return std::toupper(c);
        } else if (case_input == "reverse") {
            return std::islower(c) ? std::toupper(c) : std::tolower(c);
        } else {
            return c;
        }
    });

    fs::path new_path = item_path.parent_path() / new_name;

    try {
        fs::rename(item_path, new_path);
        if (verbose) {
            std::string item_type = is_directory ? "directory" : "file";
            print_message("\033[92mRenamed\033[0m " + item_type + " " + item_path.string() + " to " + new_path.string());
        }
        if (!is_directory) {
            ++files_count; // Increment files count
        } else {
            ++dirs_count; // Increment directories count
        }
    } catch (const std::filesystem::filesystem_error& e) {
        print_error("\033[91mError\033[0m: " + std::string(e.what()));
    }
}

void rename_directory(const fs::path& directory_path, const std::string& case_input, bool rename_immediate_parent, bool verbose, int& files_count, int& dirs_count) {
    fs::path new_path = directory_path;
    std::string dirname = directory_path.filename().string();
    std::string new_dirname;
    new_dirname.resize(dirname.size());

    std::transform(dirname.begin(), dirname.end(), new_dirname.begin(), [case_input](unsigned char c) -> unsigned char {
        if (case_input == "lower") {
            return std::tolower(c);
        } else if (case_input == "upper") {
            return std::toupper(c);
        } else if (case_input == "reverse") {
            return std::islower(c) ? std::toupper(c) : std::tolower(c);
        } else {
            return c;
        }
    });

    new_path.remove_filename(); // Remove the last component (file name) from the path
    new_path /= new_dirname; // Append the new directory name

    try {
        fs::rename(directory_path, new_path);
        if (verbose) {
            print_message("\033[94mRenamed\033[0m directory " + directory_path.string() + " to " + new_path.string());
        }
        ++dirs_count; // Increment directories count
    } catch (const std::filesystem::filesystem_error& e) {
        print_error("Error: " + std::string(e.what()));
    }

    // Recursively rename all contents within the directory
    for (const auto& entry : fs::directory_iterator(new_path)) {
        if (entry.is_directory()) {
            rename_directory(entry.path(), case_input, rename_immediate_parent, verbose, files_count, dirs_count);
        } else {
            rename_item(entry.path(), case_input, false, verbose, files_count, dirs_count);
        }
    }

    if (rename_immediate_parent) {
        // If rename_immediate_parent is true, do not recursively rename
        return;
    }
}

void rename_path(const std::vector<std::string>& paths, const std::string& case_input, bool rename_immediate_parent, bool verbose = true) {
    std::vector<std::thread> threads;

    unsigned int max_threads = std::thread::hardware_concurrency();
    if (max_threads == 0) {
        max_threads = 2; // If hardware concurrency is not available, default to 1 thread
    }

    auto start_time = std::chrono::steady_clock::now(); // Start time measurement

    int files_count = 0; // Initialize files count
    int dirs_count = 0;  // Initialize directories count

    for (const auto& path : paths) {
        fs::path current_path(path);

        if (fs::exists(current_path)) {
            if (fs::is_directory(current_path)) {
                if (rename_immediate_parent) {
                    // If -p option is used, only rename the immediate parent
                    fs::path immediate_parent_path = current_path.parent_path();
                    rename_directory(immediate_parent_path, case_input, rename_immediate_parent, verbose, files_count, dirs_count);
                } else {
                    // Otherwise, rename the entire path
                    if (threads.size() < max_threads) {
                        threads.emplace_back(rename_directory, current_path, case_input, rename_immediate_parent, verbose, std::ref(files_count), std::ref(dirs_count));
                    } else {
                        rename_directory(current_path, case_input, rename_immediate_parent, verbose, files_count, dirs_count);
                    }
                }
            } else if (fs::is_regular_file(current_path)) {
                // For files, directly rename the item without considering the parent directory
                rename_item(current_path, case_input, false, verbose, files_count, dirs_count);
            } else {
                print_error("Error: specified path is neither a directory nor a regular file");
            }
        } else {
            print_error("Error: path does not exist - " + path);
        }
    }

    // Wait for all threads to finish
    for (auto& thread : threads) {
        thread.join();
    }

    auto end_time = std::chrono::steady_clock::now(); // End time measurement

    std::chrono::duration<double> elapsed_seconds = end_time - start_time; // Calculate elapsed time

    std::cout << "\n\033[1mRenamed to "<< case_input <<" case: \033[1;92m" << files_count << " file(s) \033[0m\033[1mand \033[1;94m" 
              << dirs_count << " dir(s) \033[0m\033[1mfrom \033[1;95m" << paths.size() 
              << " input path(s) \033[0m\033[1min " << std::setprecision(1) 
              << std::fixed << elapsed_seconds.count() << "\033[1m second(s)\n";
}

int main(int argc, char *argv[]) {
    std::vector<std::string> paths; // Vector to store paths
    std::string case_input;
    bool rename_parents = false;

    // Check if the user requested help
    if (argc >= 2) {
        for (int i = 1; i < argc; ++i) {
            std::string arg(argv[i]);
            if (arg == "-v" || arg== "--verbose") {
                verbose_enabled = true;
            } else if (arg == "-h" || arg == "--help") {
                print_help();
                return 0;
                
            } else if (arg == "-cp") {
                rename_parents = true;
                if (i + 1 < argc) {
                    case_input = argv[++i]; // Get the case conversion mode
                    // Check if the case mode is valid
                    if (case_input != "lower" && case_input != "upper" && case_input != "reverse") {
                        print_error("Error: Unspecified case mode. Please specify 'lower', 'upper', or 'reverse'.");
                        return 1;
                    }
                } else {
                    print_error("Error: Missing argument for option -cp");
                    return 1;
                }
            } else if (arg == "-c") {
                if (i + 1 < argc) {
                    case_input = argv[++i]; // Get the case conversion mode
                    // Check if the case mode is valid
                    if (case_input != "lower" && case_input != "upper" && case_input != "reverse") {
                        print_error("Error: Unspecified case mode. Please specify 'lower', 'upper', or 'reverse'.");
                        return 1;
                    }
                } else {
                    print_error("Error: Missing argument for option -c");
                    return 1;
                }
            } else {
                paths.emplace_back(arg);
            }
        }
    }

    // If no paths provided, prompt the user for input
    if (paths.empty()) {
        while (true) {
            char *line = safe_readline("Enter path to rename (type 'exit' to quit): ");

            // Check for exit command
            if (line != nullptr && std::string(line) == "exit") {
                free(line);
                print_error("Exiting path input.");
                return 1;
            }

            // Add line to history
            if (line && *line) {
                add_history(line);
            }

            // Copy line to path_input and free line
            std::string path_input = line;
            free(line);

            // Check if path exists
            if (!fs::exists(path_input)) {
                print_error("Error: path does not exist");
            } else {
                paths.emplace_back(path_input);
            }
        }
    }

    if (case_input.empty()) {
        print_error("Error: Case conversion mode not specified.");
        return 1;
    }

    // Clear the screen and display warning
    system("clear");
    print_message("\n\033[1;93m!!! WARNING OPERATION IRREVERSIBLE !!!\033[0m\n");

    // Confirm renaming for all paths
    std::string confirmation;
    if (rename_parents == true) {
        std::cout << "\033[1mThe following path(s) including their parent dir(s) are about to be renamed recursively to \033[1;92m"<< case_input <<" case\033[0m:\033[1m\n\n";
        for (const auto& path : paths) {
            std::cout << path << std::endl;
        }
    } else {
        std::cout << "\033[1mThe following path(s) are about to be renamed recursively to \033[1;92m"<< case_input <<" case\033[0m:\033[1m\n\n";
        for (const auto& path : paths) {
            std::cout << path << std::endl;
        }
    }
    std::cout << "\nDo you want to proceed with renaming all these paths? (y/n): ";
    std::getline(std::cin, confirmation);

    if (confirmation != "y") {
        std::cout << "\n\033[1;91mOperation aborted by user.\n\033[0m\n";
        return 0;
    }
    
    // Process each path based on the chosen case conversion mode
    rename_path(paths, case_input, rename_parents, verbose_enabled);
    
    std::cout << "\n";

    return 0;
}

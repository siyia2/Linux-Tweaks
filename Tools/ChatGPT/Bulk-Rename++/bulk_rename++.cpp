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

namespace fs = std::filesystem;

bool verbose;

std::mutex cout_mutex;  // Mutex to protect std::cout
std::mutex input_mutex;   // Mutex to protect input operations

char* safe_readline(const char* prompt) {
    std::lock_guard<std::mutex> lock(input_mutex);
    return readline(prompt);
}

void print_message(const std::string& message) {
    std::lock_guard<std::mutex> lock(cout_mutex);
    std::cout << message << std::endl;
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
              << "  -c, --case [MODE]    Set the case conversion mode (lower/upper/reverse)\n"
              << "\n"
              << "Examples:\n"
              << "  rename /path/to/folder1 /path/to/folder2 -c lower\n"
              << "  rename /path/to/folder -c upper\n";
}

void rename_item(const fs::path& item_path, const std::string& case_input, bool is_directory, bool verbose) {
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
            print_message("Renamed " + item_type + " " + item_path.string() + " to " + new_path.string());
        }
    } catch (const std::filesystem::filesystem_error& e) {
        print_error("Error: " + std::string(e.what()));
    }
}

void rename_directory(const fs::path& directory_path, const std::string& case_input, bool rename_parents, bool verbose) {
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

    fs::path new_path = directory_path.parent_path() / new_dirname;

    for (const auto& entry : fs::directory_iterator(directory_path)) {
        if (entry.is_symlink()) {
            if (verbose) {
                print_message("Skipping symlink " + entry.path().string());
            }
            continue;
        }

        if (entry.is_directory()) {
            rename_directory(entry.path(), case_input, rename_parents, verbose);
        } else {
            rename_item(entry.path(), case_input, false, verbose);
        }
    }

    try {
        fs::rename(directory_path, new_path);
        if (verbose) {
            print_message("Renamed directory " + directory_path.string() + " to " + new_path.string());
        }
    } catch (const std::filesystem::filesystem_error& e) {
        print_error("Error: " + std::string(e.what()));
    }

    if (rename_parents && directory_path.parent_path() != directory_path.root_path()) {
        rename_directory(directory_path.parent_path(), case_input, rename_parents, verbose);
    }
}

void rename_path(const std::vector<std::string>& paths, const std::string& case_input, bool rename_parents, bool verbose = true) {

    std::vector<std::thread> threads;

    unsigned int max_threads = std::thread::hardware_concurrency();
    if (max_threads == 0) {
        max_threads = 1; // If hardware concurrency is not available, default to 1 thread
    }

    for (const auto& path : paths) {
        fs::path current_path(path);

        if (fs::exists(current_path)) {
            if (fs::is_directory(current_path)) {
                if (threads.size() < max_threads) {
                    threads.emplace_back(rename_directory, current_path, case_input, rename_parents, verbose);
                } else {
                    rename_directory(current_path, case_input, rename_parents, verbose);
                }
            } else if (fs::is_regular_file(current_path)) {
                if (threads.size() < max_threads) {
                    threads.emplace_back(rename_item, current_path, case_input, false, verbose);
                } else {
                    rename_item(current_path, case_input, false, verbose);
                }
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
}

int main(int argc, char *argv[]) {
    std::vector<std::string> paths; // Vector to store paths
    std::string case_input;
    bool rename_parents = false;

    // Check if the user requested help
    if (argc >= 2) {
        for (int i = 1; i < argc; ++i) {
            if (argv[i][0] == '-') { // Check if it's an option
                std::string option(argv[i]);
                if (option == "-h" || option == "--help") {
                    print_help();
                    return 0;
                } else if (option == "-c" || option == "--case") {
                    if (i + 1 < argc) {
                        case_input = argv[++i]; // Get the case conversion mode
                    } else {
                        print_error("Error: Missing argument for option -c");
                        return 1;
                    }
                
                } else {
                    print_error("Error: Unknown option " + option);
                    print_help();
                    return 1;
                }
            } else { // If it's not an option, it's a path
                paths.emplace_back(argv[i]);
            }
        }
    }

    // If no paths provided, prompt the user for paths
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

    print_message("!!! WARNING OPERATION IRREVERSIBLE !!!");

    // Confirm renaming for all paths
    std::string confirmation;
    std::cout << "The following paths are about to be renamed:\n";
    for (const auto& path : paths) {
        std::cout << path << std::endl;
    }
    std::cout << "Do you want to proceed with renaming all these paths? (y/n): ";
    std::getline(std::cin, confirmation);

    if (confirmation != "y") {
        std::cout << "Operation aborted by user.\n";
        return 0;
    }

    // Process each path based on the chosen case conversion mode
    rename_path(paths, case_input, rename_parents, true);

    return 0;
}

#include <iostream>
#include <string>
#include <filesystem>
#include <algorithm>
#include <vector>
#include <thread>
#include <mutex>
#include <readline/readline.h>
#include <readline/history.h>

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
  std::cout << "Usage: rename [PATH] [OPTIONS]\n"
            << "Renames all files and folders under the specified path.\n"
            << "\n"
            << "Options:\n"
            << "  -h, --help           Print this message and exit\n"
            << "  -c, --case [MODE]    Set the case conversion mode (lower/upper/reverse)\n"
            << "\n"
            << "Examples:\n"
            << "  rename /path/to/folder -c lower\n"
            << "  rename /path/to/folder -c upper\n"
            << "  rename /path/to/folder -c reverse\n";
}

void rename_item(const fs::path& item_path, const std::string& case_input, bool is_directory, bool verbose) {
  std::string name = item_path.filename().string();
  std::string new_name;
  new_name.resize(name.size()); // Resize new_name

  std::transform(name.begin(), name.end(), new_name.begin(), [case_input](unsigned char c) {
    if (case_input == "lower") {
      return std::tolower(c);
    } else if (case_input == "upper") {
      return std::toupper(c);
    } else if (case_input == "reverse") {
      return std::islower(c) ? std::toupper(c) : std::tolower(c);
    } else {
          return std::tolower(c);
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

void rename_directory(const fs::path& directory_path, const std::string& case_input, bool verbose) {
  std::string dirname = directory_path.filename().string();
  std::string new_dirname;
  new_dirname.resize(dirname.size());

  std::transform(dirname.begin(), dirname.end(), new_dirname.begin(), [case_input](unsigned char c) {
    if (case_input == "lower") {
      return std::tolower(c);
    } else if (case_input == "upper") {
      return std::toupper(c);
    } else if (case_input == "reverse") {
      return std::islower(c) ? std::toupper(c) : std::tolower(c);
    } else {
      return std::tolower(c);
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
      rename_directory(entry.path(), case_input, verbose);
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
}

void rename_path(const fs::path& path, const std::string& case_input, bool verbose=true) {
  std::vector<std::thread> threads;

  unsigned int max_threads = std::thread::hardware_concurrency();
  if (max_threads == 0) {
    max_threads = 1; // If hardware concurrency is not available, default to 1 thread
  }

  for (const auto& entry : fs::directory_iterator(path)) {
    if (entry.is_symlink()) {
      if (verbose) {
        print_message("Skipping symlink " + entry.path().string());
      }
      continue;
    }

    if (entry.is_directory()) {
      if (threads.size() < max_threads) {
        threads.emplace_back(rename_directory, entry.path(), case_input, verbose);
      } else {
        rename_directory(entry.path(), case_input, verbose);
      }
    } else if (entry.is_regular_file()) {
      if (threads.size() < max_threads) {
        threads.emplace_back(rename_item, entry.path(), case_input, false, verbose);
      } else {
        rename_item(entry.path(), case_input, false, verbose);
      }
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

    // Check if the user requested help
    if (argc == 2 && (std::string(argv[1]) == "-h" || std::string(argv[1]) == "--help")) {
        // Print help message and exit
        print_help();
        return 0;
    } else if (argc > 1) {
        // Collect paths from command line arguments
        for (int i = 1; i < argc; ++i) {
            paths.emplace_back(argv[i]);
        }
    } else {
        // If no command-line arguments are provided, prompt the user for paths
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

    print_message("!!! WARNING OPERATION IRREVERSIBLE !!!");

    // Prompt for case conversion mode
    while (true) {
        std::cout << "Enter case (lower/upper/reverse/exit): ";
        std::getline(std::cin, case_input);

        std::transform(case_input.begin(), case_input.end(), case_input.begin(),
                       [](unsigned char c) { return std::tolower(c); });

        if (case_input == "lower" || case_input == "upper" || case_input == "reverse" || case_input == "exit") {
            break;
        } else {
            print_error("Error: invalid choice");
        }
    }

    // Process each path based on the chosen case conversion mode
    for (const auto& path : paths) {
        fs::path current_path(path);

        if (fs::exists(current_path)) {
            if (fs::is_directory(current_path)) {
                rename_path(current_path, case_input, true);
            } else if (fs::is_regular_file(current_path)) {
                rename_item(current_path, case_input, false, true);
            } else {
                print_error("Error: specified path is neither a directory nor a regular file");
            }
        } else {
            print_error("Error: path does not exist - " + path);
        }
    }

    return 0;
}

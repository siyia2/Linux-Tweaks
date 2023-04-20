#include <iostream>
#include <string>
#include <filesystem>
#include <algorithm>
#include <readline/readline.h>
#include <readline/history.h>
// compile with g++ bulk_rename++.cpp -o bulk_rename++ -lreadline
namespace fs = std::filesystem;

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

void rename_path(const fs::path& path, const std::string& case_input) {
  for (const auto& entry : fs::directory_iterator(path)) {

    if (entry.is_directory()) {
      // Rename subdirectories recursively
      const auto& sub_path = entry.path();
      rename_path(sub_path, case_input);

      std::string dirname = sub_path.filename().string();
      std::string new_dirname;
      new_dirname.resize(dirname.size());

      if (case_input == "lower") {
        std::transform(dirname.begin(), dirname.end(), new_dirname.begin(),
                       [](unsigned char c) { return std::tolower(c); });
      } else if (case_input == "upper") {
        std::transform(dirname.begin(), dirname.end(), new_dirname.begin(),
                       [](unsigned char c) { return std::toupper(c); });
      } else if (case_input == "reverse") {
        std::transform(dirname.begin(), dirname.end(), new_dirname.begin(),
                       [](unsigned char c) {
                         return std::islower(c) ? std::toupper(c) : std::tolower(c);
                       });
      }

      fs::path new_path = sub_path.parent_path() / new_dirname;
      try {
        fs::rename(sub_path, new_path);
      } catch (const std::filesystem::filesystem_error& e) {
        std::cerr << "Error: " << e.what() << '\n';
      }

    } else if (entry.is_regular_file()) {
      std::string filename = entry.path().filename().string();
      std::string new_filename;
      new_filename.resize(filename.size()); // Resize new_filename
      if (case_input == "exit") { 
	break;
      }
      if (case_input == "lower") {
        std::transform(filename.begin(), filename.end(), new_filename.begin(),
                       [](unsigned char c) { return std::tolower(c); });
      } else if (case_input == "upper") {
        std::transform(filename.begin(), filename.end(), new_filename.begin(),
                       [](unsigned char c) { return std::toupper(c); });
      } else if (case_input == "reverse") {
        std::transform(filename.begin(), filename.end(), new_filename.begin(),
                       [](unsigned char c) {
                         return std::islower(c) ? std::toupper(c) : std::tolower(c);
                       });
      }

      fs::path new_path = entry.path().parent_path() / new_filename;
      try {
        fs::rename(entry.path(), new_path);
      } catch (const std::filesystem::filesystem_error& e) {
        std::cerr << "Error: " << e.what() << '\n';
      }
    }
  }
}

int main(int argc, char *argv[]) {
  if (argc == 2 && (std::string(argv[1]) == "-h" || std::string(argv[1]) == "--help")) {
    // Print help message and exit
    print_help();
    return 0;
  }

  // Enable tab completion for path input
  rl_bind_key('\t', rl_complete);

  std::string path_input;
  const char* path_completion = rl_basic_word_break_characters;
  while (true) {
    // Read line with readline()
    char *line = readline("Enter path to rename: ");

    // Add line to history
    if (line && *line) {
      add_history(line);
    }

    // Copy line to path_input and free line
    path_input = line;
    free(line);

    // Use tab completion if available
    if (path_completion) {
      // Attempt tab completion
      char *completion = rl_filename_completion_function(path_input.c_str(), path_completion[0]);

      if (completion != NULL) {
        if (completion) {
          // Print completion and add it to path_input
          std::cout << completion;
          path_input = completion;
          free(completion);
        }
      }
    }

    // Check if path exists
    if (!fs::exists(path_input)) {
      std::cerr << "Error: path does not exist\n";
    } else {
      break;
    }
  }

  std::string case_input;
  printf("!!! WARNING OPERATION IRREVERSIBLE !!! \n");
  std::cout << "Enter case (lower/upper/reverse/exit): ";
  std::getline(std::cin, case_input);

  std::transform(case_input.begin(), case_input.end(), case_input.begin(),
                 [](unsigned char c) { return std::tolower(c); });

  fs::path path(path_input);

  rename_path(path, case_input);

  return 0;
}


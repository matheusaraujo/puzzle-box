#include <iostream>
#include <vector>
#include <string>

std::string part1(const std::vector<std::string>& input);
std::string part2(const std::vector<std::string>& input);
std::string part3(const std::vector<std::string>& input);

int main(int argc, char* argv[]) {
    if (argc < 5) return 1;
    std::string part = argv[4];

    std::vector<std::string> puzzleInput;
    std::string line;
    while (std::getline(std::cin, line)) {
        puzzleInput.push_back(line);
    }

    if (part == "part1") {
        std::cout << part1(puzzleInput) << std::endl;
    } else if (part == "part2") {
        std::cout << part2(puzzleInput) << std::endl;
    } else if (part == "part3") {
        std::cout << part3(puzzleInput) << std::endl;
    } else {
        std::cerr << "Unknown part: " << part << std::endl;
        return 1;
    }

    return 0;
}
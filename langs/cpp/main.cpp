#include <any>
#include <iostream>
#include <vector>
#include <string>

using namespace std;

any part1(const vector<string>& input);
any part2(const vector<string>& input);
any part3(const vector<string>& input);

int main(int argc, char* argv[]) {
    string part = argv[2];

    vector<string> puzzleInput;
    string line;
    while (getline(cin, line)) {
        puzzleInput.push_back(line);
    }

    any result;

    if (part == "part1") {
        result = part1(puzzleInput);
    } else if (part == "part2") {
        result = part2(puzzleInput);
    } else if (part == "part3") {
        result = part3(puzzleInput);
    } else {
        cerr << "Unknown part: " << part << endl;
        return 1;
    }

    try {
        if (result.type() == typeid(int)) {
            cout << any_cast<int>(result) << endl;
        } else if (result.type() == typeid(size_t)) {
            cout << any_cast<size_t>(result) << endl;
        } else if (result.type() == typeid(string)) {
            cout << any_cast<string>(result) << endl;
        } else if (result.type() == typeid(long)) {
            cout << any_cast<long>(result) << endl;
        } else if (result.type() == typeid(long int)) {
            cout << any_cast<long int>(result) << endl;
        } else if (result.type() == typeid(long long)) {
            cout << any_cast<long long>(result) << endl;
        }
    } catch (const bad_any_cast& e) {
        cerr << "Error: Could not cast result for printing." << endl;
    }

    return 0;
}
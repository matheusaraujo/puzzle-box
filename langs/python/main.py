import sys

solution_path,  part = sys.argv[1], sys.argv[2]

sys.path.append(solution_path)

if part == "part1":
    from part1 import part1 as func
elif part == "part2":
    from part2 import part2 as func
elif part == "part3":
    from part3 import part3 as func


def main():
    input_data = [x.replace("\n", "") for x in sys.stdin.readlines()]
    print(func(input_data))


if __name__ == "__main__":
    main()

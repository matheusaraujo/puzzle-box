package main

import (
	"bufio"
	"fmt"
	"os"
)

func main() {
	part := os.Args[4]
	var puzzleInput []string

	scanner := bufio.NewScanner(os.Stdin)
	for scanner.Scan() {
		line := scanner.Text()
		puzzleInput = append(puzzleInput, line)
	}

	if err := scanner.Err(); err != nil {
		fmt.Println("Error reading input:", err)
		return
	}

	switch part {
	case "part1":
		fmt.Println(part1(puzzleInput))
	case "part2":
		fmt.Println(part2(puzzleInput))
	case "part3":
		fmt.Println(part3(puzzleInput))
	default:
		fmt.Println("Unknown part:", part)
	}
}

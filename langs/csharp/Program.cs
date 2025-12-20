namespace PuzzleBox;

public class Program
{
    static void Main(string[] args)
    {
        string part = args[3];

        var puzzleInput = new List<string>();
        string? input;

        while ((input = Console.ReadLine()) != null)
        {
            puzzleInput.Add(input);
        }

        if (part == "part1")
            Console.WriteLine(Part1.Solve(puzzleInput));
        else if (part == "part2")
            Console.WriteLine(Part2.Solve(puzzleInput));
        else if (part == "part3")
            Console.WriteLine(Part3.Solve(puzzleInput));
    }
}

import java.util.ArrayList;
import java.util.List;
import java.util.Scanner;

public class main {
    public static void main(String[] args) {

        String part = args[3];
        List<String> puzzleInput = new ArrayList<>();

        Scanner scanner = new Scanner(System.in);
        while (scanner.hasNextLine()) {
            puzzleInput.add(scanner.nextLine());
        }
        scanner.close();

        if (part.equals("part1")) {
            System.out.println(part1.solve(puzzleInput));
        } else if (part.equals("part2")) {
            System.out.println(part2.solve(puzzleInput));
        } else if (part.equals("part3")) {
            System.out.println(part3.solve(puzzleInput));
        }
    }
}
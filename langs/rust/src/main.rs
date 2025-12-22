use std::env;
use std::fmt::Display;
use std::io::{self, BufRead};

mod helpers;
mod part1;
mod part2;
mod part3;

pub type Any = Box<dyn Display>;
pub fn any<T: Display + 'static>(val: T) -> Any {
    Box::new(val) as Any
}

fn main() {
    let args: Vec<String> = env::args().collect();
    let part = &args[2];

    let stdin = io::stdin();
    let reader = stdin.lock();
    let mut puzzle_input: Vec<String> = Vec::new();

    for line in reader.lines() {
        match line {
            Ok(l) => puzzle_input.push(l),
            Err(e) => {
                eprintln!("Error reading input: {}", e);
                std::process::exit(1);
            }
        }
    }

    match part.as_str() {
        "part1" => println!("{}", part1::part1(&puzzle_input)),
        "part2" => println!("{}", part2::part2(&puzzle_input)),
        "part3" => println!("{}", part3::part3(&puzzle_input)),
        other => println!("Unknown part: {}", other),
    }
}

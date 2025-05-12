use std::fs;
use std::iter::zip;

fn main() {
  let input = get_input();
  for (i, s) in zip(1..=input.len(), input.iter()) {
    let ans = calc(s, i);
    println!("Part {i} answer: {ans}");
  }
}

fn get_input() -> Vec<String> {
  vec![
    fs::read_to_string("input1.txt").unwrap(),
    fs::read_to_string("input2.txt").unwrap(),
    fs::read_to_string("input3.txt").unwrap()
  ]
}

fn calc(s: &str, l: usize) -> usize {
  let a = s.chars().fold(0, |acc, c| acc + score(c));
  let b = s.chars().collect::<Vec<_>>().chunks(l).fold(0, |acc, chunk| acc + extra(chunk));

  a + b
}

fn score(c: char) -> usize {
  match c {
    'A' => 0,
    'B' => 1,
    'C' => 3,
    'D' => 5,
    'x' => 0,
    _ => panic!("Invalid input")
  }
}

fn extra(s: &[char]) -> usize {
  let n = s.into_iter().filter(|&&c| c != 'x').collect::<Vec<_>>().len();
  n * n - n
}
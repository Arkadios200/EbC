use std::fs;
use std::iter::zip;

fn main() {
  let input = vec![
    fs::read_to_string("input1.txt").unwrap(),
    fs::read_to_string("input2.txt").unwrap(),
    fs::read_to_string("input3.txt").unwrap()
  ];

  for (i, s) in zip(1.., input.iter()) {
    let ans = calc(s, i);
    println!("Part {i} answer: {ans}");
  }
}

fn calc(s: &str, l: usize) -> usize {
  let scores = HashMap::<char, usize>::from([
    ('A', 0),
    ('B', 1),
    ('C', 3),
    ('D', 5),
    ('x', 0)
  ]);

  let a = s.chars().fold(0, |acc, c| acc + scores.get(&c).expect("Invalid input"));
  let b = s.chars().collect::<Vec<_>>().chunks(l).fold(0, |acc, chunk| acc + extra(chunk));

  a + b
}

fn extra(s: &[char]) -> usize {
  let n = s.into_iter().filter(|&&c| c != 'x').count();
  n * n - n
}
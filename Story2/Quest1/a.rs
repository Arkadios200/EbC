use std::fs;
use std::collections::HashSet;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let (nails, coins) = process(&input);
  let width = nails.iter().map(|&p| p.x).max().unwrap();
  let height = nails.iter().map(|&p| p.y).max().unwrap();

  let mut total = 0;
  for (x, coin) in (1..=9).map(|x| (x - 1) * 2).zip(coins) {
    let mut p = Point { x, y: 0 };
    let mut c = coin.chars().cycle();

    while p.y <= height {
      if nails.contains(&p) {
        let d = c.next().unwrap();
        p.x += match p.x {
          0 => 1,
          _ if p.x == width => -1,
          _ => if d == 'R' { 1 } else { -1 },
        }
      }

      p.y += 1;
    }

    let score = (p.x / 2 + 1) * 2 - (x / 2 + 1);
    total += if score > 0 { score } else { 0 };
  }

  println!("{total}");
}

fn process(input: &str) -> (HashSet<Point>, Vec<String>) {
  let mut blocks = input.split("\n\n");

  let grid = blocks.next().unwrap();
  let mut nails: HashSet<Point> = HashSet::new();
  for (i, line) in grid.lines().enumerate() {
    for (j, c) in line.chars().enumerate() {
      if c == '*' { nails.insert(Point { x: j as i32, y: i as i32 }); }
    }
  }

  let coins: Vec<String> = blocks.next().unwrap().lines().map(|s| String::from(s)).collect();

  (nails, coins)
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: i32,
  y: i32,
}
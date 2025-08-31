use std::fs;
use std::collections::HashSet;

fn main() {
  let input = fs::read_to_string("input.txt").unwrap();

  let (board, coins) = process(&input);

  let total: i32 = coins.iter().map(|coin| (1i32..=Board::slot(board.width())).map(|x| (2 * coin.simulate(&board, x)) - x).max().unwrap()).sum();
  println!("{total}");
}

fn process(input: &str) -> (Board, Vec<Coin>) {
  let mut blocks = input.split("\n\n");

  let mut nails: HashSet<Point> = HashSet::new();
  for (i, line) in blocks.next().unwrap().lines().enumerate() {
    for (j, c) in line.chars().enumerate() {
      if c == '*' {
        nails.insert(Point { x: j as i32, y: i as i32 });
      }
    }
  }

  let coins: Vec<Coin> = blocks.next().unwrap().lines().map(|line| Coin { dirs: line.chars().map(|c| match c { 'L' => -1, 'R' => 1, _ => panic!(), }).collect() }).collect();

  (Board { nails }, coins)
}

#[derive(Debug, Clone, Copy, PartialEq, Eq, Hash)]
struct Point {
  x: i32,
  y: i32,
}

#[derive(Clone)]
struct Board {
  nails: HashSet<Point>,
}

impl Board {
  fn width(&self) -> i32 {
    self.nails.iter().map(|&p| p.x).max().unwrap()
  }

  fn height(&self) -> i32 {
    self.nails.iter().map(|&p| p.y).max().unwrap()
  }

  fn slot(x: i32) -> i32 {
    x / 2 + 1
  }

  fn x(slot: i32) -> i32 {
    (slot - 1) * 2
  }
}

#[derive(Clone)]
struct Coin {
  dirs: Vec<i32>
}

impl Coin {
  fn simulate(&self, board: &Board, slot: i32) -> i32 {
    let mut pos = Point { x: Board::x(slot), y: 0 };
    let mut dirs = self.dirs.iter().cycle();

    while pos.y <= board.height() {
      if board.nails.contains(&pos) {
        let d = *dirs.next().unwrap();
        pos.x += match pos.x {
          0 => 1,
          _ if pos.x == board.width() => -1,
          _ => d,
        }
      }

      pos.y += 1;
    }

    Board::slot(pos.x)
  }
}

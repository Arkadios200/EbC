const SAMPLE: [i32; 6] = [3, 11, 12, 16, 24, 25];

fn main() {
  for (i, p) in (1..).zip([part1, part2, part3]) {
    let ans: i32 = SAMPLE.iter().map(p).sum();
    println!("Part {i} answer: {ans}");
  }
}

fn part1(n: &i32) -> i32 {
  let mut s = 1;
  loop {
    let v = s * s;
    if v.ge(n) {
      return v - n;
    } else {
      s += 1;
    }
  }
}

fn part2(n: &i32) -> i32 {
  let mut s = 3;
  loop {
    let v = 4 * (s - 1);
    if v.ge(n) {
      return v - n;
    } else {
      s += 1;
    }
  }
}

fn part3(n: &i32) -> i32 {
  let mut s = 3;
  loop {
    let v = s * s - 1;
    if v.ge(n) {
      return v - n;
    } else {
      s += 2;
    }
  }
}
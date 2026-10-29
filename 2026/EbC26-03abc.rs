use std::ops::Rem;

const SAMPLE1: &str = "\
  ISO-3210 7654\n\
  ISO-8742 2468\n\
  ISO-1111 1111\
";

const SAMPLE2: &str = "\
  ISO-3210 7654\n\
  ISO-8742 2468\n\
  ISO-1 1111\n\
  ISO-13 777\n\
  ISO-34 140856\n\
  ISO-789 2465112\n\
  ISO-2341 945\
";

const SAMPLE3: &str = "\
  ISO2-3 23\n\
  ISO2-61 149\n\
  ISO2-978 99\n\
  ISO2-5887 5923\n\
  ISO2-76988 123749\n\
  ISO2-435657 929977\n\
  ISO2-3949 870737\
";

fn main() {
  let ans1: u64 = process_input(SAMPLE1).into_iter()
    .map(|(iso, num)| part1(iso, num))
    .sum();
  let ans2: u64 = process_input(SAMPLE2).into_iter()
    .map(|(iso, num)| part2(iso, num))
    .sum();
  let ans3: u64 = process_input(SAMPLE3).into_iter()
    .filter_map(|(iso, num)| part3(iso, num))
    .sum();
  
  println!("Part 1 answer: {ans1}");
  println!("Part 2 answer: {ans2}");
  println!("Part 3 answer: {ans3}");
}

fn part1(mut iso: u64, mut num: u64) -> u64 {
  let mut ans: u64 = 0;
  let mut p: u32 = 0;
  while num > 0 {
    ans += num.rem(10) * iso.rem(10).pow(p);

    num /= 10;
    iso /= 10;
    p += 1;
  }

  ans
}

// Works for part 1 as well.
fn part2(iso: u64, mut num: u64) -> u64 {
  let mut ans: u64 = 0;
  let mut iso_loop: u64 = iso;
  let mut p: u32 = 0;
  while num > 0 {
    ans += num.rem(10) * iso_loop.rem(10).pow(p);

    num /= 10;
    iso_loop /= 10;
    if iso_loop == 0 { iso_loop = iso; }
    p += 1;
  }

  ans
}

fn part3(iso: u64, num: u64) -> Option<u64> {
  let ans = part2(iso, num);

  if (1..num).all(|n| part2(iso, n) != ans) {
    Some(ans)
  } else {
    None
  }
}

fn process_input(s: &str) -> Vec<(u64, u64)> {
  s.lines().map(process).collect()
}

fn process(line: &str) -> (u64, u64) {
  let mut s = line.split(|c: char| !char::is_digit(c, 10)).rev().take(2);

  let num: u64 = s.next().unwrap().parse().unwrap();
  let iso: u64 = s.next().unwrap().parse().unwrap();

  (iso, num)
}
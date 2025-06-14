func getInput() -> [Int] {
  var nums: [Int] = []
  while let line = readLine() {
    nums.append(Int(line)!)
  }

  return nums
}

let nums = getInput()
let goal = nums.min()!
let ans = nums.reduce(0) { $0 + $1 - goal }

print(ans)
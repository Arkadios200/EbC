func getInput() -> [Int] {
  var nums: [Int] = []
  while let line = readLine() {
    nums.append(Int(line)!)
  }

  return nums
}

let nums = getInput()
let goal = nums.sorted()[nums.count/2]
let ans = nums.reduce(0) { $0 + abs($1 - goal) }

print(ans)
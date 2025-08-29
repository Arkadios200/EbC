extension Collection {
  func get(at index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}

struct Die {
  let id: Int
  let faces: [Int]
  let seed: Int
  var pulse: Int
  var rollNumber: Int = 1
  var i: Int = 0
  var result: Int { return faces[i] }

  init(nums: [Int]) {
    var nums = nums

    self.id = nums.removeFirst()
    self.seed = nums.removeLast()
    self.pulse = seed
    self.faces = nums
  }

  @discardableResult
  mutating func roll() -> Int {
    let spin = rollNumber * pulse
    i = (i + spin) % faces.count

    pulse += spin
    pulse %= seed
    pulse += rollNumber + seed + 1

    rollNumber += 1

    return result
  }
}

func getInput() -> ([Die], [Int]) {
  var dice: [Die] = []
  while let line = readLine(), !line.isEmpty {
    dice.append(Die(nums: line.split { !"-0123456789".contains($0) }.map { Int($0)! }))
  }

  let track = Array(readLine()!).map { $0.wholeNumberValue! }

  return (dice, track)
}

let input = getInput()
var dice = input.0.map { (0, $0) }
let track = input.1

let dist = track.count
var finish: [Int] = []
while finish.count < dice.count {
  for i in dice.indices where dice[i].0 < dist {
    if dice[i].1.roll() == track[dice[i].0] { dice[i].0 += 1 }
    if dice[i].0 == dist { finish.append(dice[i].1.id) }
  } 
}

finish.forEach { print($0, terminator: ",") }
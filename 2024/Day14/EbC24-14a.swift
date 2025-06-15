struct Point: Equatable, Hashable {
  let x: Int
  let y: Int
  let z: Int

  init(_ x: Int, _ y: Int, _ z: Int) {
    self.x = x
    self.y = y
    self.z = z
  }

  func translate(_ dir: Character, _ dist: Int = 1) -> Point {
    switch dir {
      case "R": return Point(x + dist, y, z)
      case "L": return Point(x - dist, y, z)
      case "F": return Point(x, y + dist, z)
      case "B": return Point(x, y - dist, z)
      case "U": return Point(x, y, z + dist)
      case "D": return Point(x, y, z - dist)
      default: fatalError("Invalid input")
    }
  }
}

let input: [(Character, Int)] = readLine()!.split(separator: ",").map { ($0.first!, Int($0.dropFirst())!) }

var record: Set<Point> = []

var pos = Point(0, 0, 0)
for (dir, dist) in input {
  pos = pos.translate(dir, dist)
  record.insert(pos)
}

let ans = record.map { $0.z }.max()!
print("Answer: \(ans)")
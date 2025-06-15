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

func getInput() -> [[(Character, Int)]] {
  var lines: [[(Character, Int)]] = []
  while let line = readLine() {
    lines.append(line.split(separator: ",").map { ($0.first!, Int($0.dropFirst())!) })
  }

  return lines
}

func grow(_ lines: [[(Character, Int)]]) -> Int {
  var record: Set<Point> = []
  for line in lines {
    var pos = Point(0, 0, 0)
    for (dir, dist) in line {
      for _ in 0..<dist {
        pos = pos.translate(dir)
        record.insert(pos)
      }
    }
  }

  return record.count
}

let lines = getInput()


let ans = grow(lines)
print("Answer: \(ans)")
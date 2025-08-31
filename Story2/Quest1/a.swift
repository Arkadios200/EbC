struct Point: Equatable, Hashable {
  var x: Int
  var y: Int

  init(x: Int, y: Int) {
    self.x = x
    self.y = y
  }
}

struct Board {
  let nails: Set<Point>
  let width: Int
  let height: Int

  static let slot: (Int) -> Int = { $0 / 2 + 1 }
  static let x: (Int) -> Int = { ($0 - 1) * 2 }

  init(_ nails: Set<Point>) {
    self.nails = nails
    self.width = nails.map { $0.x }.max()!
    self.height = nails.map { $0.y }.max()!
  }
}

struct Coin {
  let dirs: [Character]

  init(dirs: [Character]) {
    self.dirs = dirs
  }

  func simulate(_ board: Board, slot: Int) -> Int {
    var pos = Point(x: Board.x(slot), y: 0)

    var i = 0
    while pos.y <= board.height {
      if board.nails.contains(pos) {
        pos.x += {
          switch pos.x {
            case 0: return 1
            case board.width: return -1
            default: 
              return dirs[i] == "R" ? 1 : -1
          }
        }()
        i = (i + 1) % dirs.count
      }
      pos.y += 1
    }

    return Board.slot(pos.x)
  }
}

func getInput() -> (Board, [Coin]) {
  var grid: [[Character]] = []
  while let line = readLine(), !line.isEmpty {
    grid.append(Array(line))
  }

  var board: Set<Point> = []
  for (i, line) in grid.enumerated() {
    for (j, c) in line.enumerated() {
      if c == "*" { board.insert(Point(x: j, y: i)) }
    }
  }

  var coins: [Coin] = []
  while let line = readLine() {
    coins.append(Coin(dirs: Array(line)))
  }

  return (Board(board), coins)
}

let (board, coins) = getInput()

let ans = zip(1..., coins).map { 2 * $0.1.simulate(board, slot: $0.0) - $0.0 }.filter { $0 > 0 }.reduce(0, +)

print(ans)
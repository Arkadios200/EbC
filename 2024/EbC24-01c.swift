extension Collection {
  subscript(safe index: Index) -> Element? {
    return indices.contains(index) ? self[index] : nil
  }
}


var grid = [[Int]]()
while let line = readLine() {
  grid.append(line.map { $0 == "#" ? 1 : 0 } )
}

var newGrid = grid
var n = 1
outer: while true {
  for i in grid.indices {
    for j in grid[i].indices {
      let temp: [Int] = [
        grid[i][j],
        grid[i][safe: j+1] ?? 0,
        grid[safe: i+1]?[safe: j+1] ?? 0,
        grid[safe: i+1]?[j] ?? 0,
        grid[safe: i+1]?[safe: j-1] ?? 0,
        grid[i][safe: j-1] ?? 0,
        grid[safe: i-1]?[safe: j-1] ?? 0,
        grid[safe: i-1]?[j] ?? 0,
        grid[safe: i-1]?[safe: j+1] ?? 0
      ]
      if temp.allSatisfy( { $0 == n } ) {
        newGrid[i][j] += 1
      }
    }
  }

  if grid == newGrid {
    break outer
  } else {
    n += 1
    grid = newGrid
  }
}

var total = 0
grid.forEach {
  print($0.map { String($0) }.joined())
  total += $0.reduce(0, +)
}

print(total)

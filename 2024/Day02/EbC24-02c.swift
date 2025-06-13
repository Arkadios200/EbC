typealias Grid = [[Character]]

func getInput() -> ([String], Grid) {
  let words = readLine()!.split { !$0.isLetter }.dropFirst().map(String.init)

  var grid: Grid = []
  while let line = readLine() {
    if line.isEmpty { continue }
    grid.append(Array(line))
  }

  return (words, grid)
}

let (words, grid) = getInput()

let height = grid.count
let width = grid.first!.count
var rec = [[Bool]](repeating: [Bool](repeating: false, count: width), count: height)

for word in words {
  for i in grid.indices {
    for j in grid[i].indices {
      let xRange = (j..<j+word.count).map { $0 % width }
      let s1 = String(xRange.map( { grid[i][$0] } ))
      if s1 == word || String(s1.reversed()) == word {
        xRange.forEach { rec[i][$0] = true }
      }

      if i >= height - word.count + 1 { continue }

      let yRange = i..<(i+word.count)
      let s2 = String(grid[yRange].map( { $0[j] } ))
      if s2 == word || String(s2.reversed()) == word {
        yRange.forEach { rec[$0][j] = true }
      }
    }
  }
}

print(rec.joined().filter { $0 }.count)
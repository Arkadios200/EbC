func getInput() -> ([String], [[Character]]) {
  let words = readLine()!.drop { $0 != ":" }.split { !$0.isLetter }.map(String.init)

  var lines: [[Character]] = []
  while let line = readLine() {
    if line.isEmpty { continue }

    lines.append(Array(line))
  }

  return (words, lines)
}

let (words, lines) = getInput()

var total = 0
for line in lines {
  var record = [Bool](repeating: false, count: line.count)

  for word in words {
    for i in line.indices.dropLast(word.count-1) {
      let range = i..<i+word.count
      if String(line[range]) == word || String(line[range].reversed()) == word {
        range.forEach { record[$0] = true }
      }
    }
  }

  total += record.filter { $0 }.count
}

print(total)
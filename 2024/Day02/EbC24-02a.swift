func getInput() -> ([String], [Character]) {
  let words = readLine()!.drop { $0 != ":" }.split { !$0.isLetter }.map(String.init)

  var line: [Character] = []
  while let l = readLine() {
    if !l.isEmpty { line = Array(l) }
  }

  return (words, line)
}

let (words, line) = getInput()

var total = words.reduce(0) {
  (acc, word) in
  acc + line.indices.dropLast(word.count-1).map {
    String(line[$0..<$0+word.count])
  }.filter { $0 == word }.count
}

print(total)
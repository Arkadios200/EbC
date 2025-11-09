extension Array: Comparable where Element: Comparable {
  public static func < (lhs: Array, rhs: Array) -> Bool {
    guard let (a, b) = zip(lhs, rhs).first(where: { $0.0 != $0.1 } ) else { return false }

    return a < b
  }
}

extension Collection where Element: Comparable {
  var fishbone: [(l: Element?, s: Element, r: Element?)] {
    var fishbone: [(l: Element?, s: Element, r: Element?)] = []
    outer: for item in self {
      for (i, row) in zip(fishbone.indices, fishbone) {
        if row.l == nil && item < row.s {
          fishbone[i].l = item
          continue outer
        } else if row.r == nil && item > row.s {
          fishbone[i].r = item
          continue outer
        }
      }

      fishbone.append((nil, item, nil))
    }

    return fishbone
  }
}

extension Optional where Wrapped: CustomStringConvertible {
  func toString() -> String? {
    return self != nil ? String(describing: self!) : nil
  }
}

struct Sword {
  let id: Int
  let quality: Int
  let levels: [Int]

  init(id: Int, nums: [Int]) {
    self.id = id
    (self.quality, self.levels) = Sword.calc(nums)
  }

  private static func calc(_ nums: [Int]) -> (Int, [Int]) {
    let fishbone = nums.fishbone

    let quality = Int(fishbone.map { String($0.s) }.joined())!
    let levels = fishbone.map { Int("\($0.l.toString() ?? "")\($0.s)\($0.r.toString() ?? "")")! }

    return (quality, levels)
  }
}

extension Sword: Equatable, Comparable {
  static func < (lhs: Sword, rhs: Sword) -> Bool {
    if lhs.quality != rhs.quality {
      return lhs.quality < rhs.quality
    } else if lhs.levels != rhs.levels {
      return lhs.levels < rhs.levels
    } else {
      return lhs.id < rhs.id
    }
  }
}

func getInput() -> [Sword] {
  var swords: [Sword] = []
  while let line = readLine() {
    let temp: [Int] = line.split { !$0.isNumber }.map { Int($0)! }

    swords.append(Sword(id: temp.first!, nums: Array(temp.dropFirst())))
  }

  return swords
}

let swords = getInput()
let ans3 = zip(1..., swords.sorted(by: >).map { $0.id }).reduce(0) { $0 + $1.0 * $1.1 }

print(ans3)
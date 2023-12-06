import Algorithms

struct Day03: AdventDay {

  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [[Character]] {
    data.split(separator: "\n").map {
      Array($0)
    }
  }

  func part1() -> Any {
    var partNumbers: [PartNumber] = []
    for (index, line) in entities.enumerated() {
      partNumbers.append(
        contentsOf: findNumbersWithPosition(
          line: line, lineAbove: entities[safe: index - 1] ?? [],
          lineBelow: entities[safe: index + 1] ?? []))
    }
    let validPartNumbers = partNumbers.filter({ $0.isValid }).map({ $0.number })
      print(validPartNumbers)
    return validPartNumbers.reduce(0, +)
  }

  func part2() -> Any {
    return ""
  }
}

struct PartNumber {
  let number: Int
  let isValid: Bool
}

extension Day03 {
  func findNumbersWithPosition(line: [Character], lineAbove: [Character], lineBelow: [Character])
    -> [PartNumber]
  {
    var foundNumbers: [PartNumber] = []
    var currentNumber: String? = nil
    var currentIsValid = false

    for (index, char) in line.enumerated() {
        
        if char.isNumber {
          if currentNumber == nil {
            currentNumber = ""
          }
          if !currentIsValid {
            currentIsValid = areAnySymbolsAdjacent(
              line: line, lineAbove: lineAbove, lineBelow: lineBelow, position: index)
          }
          currentNumber?.append(char)
        }
        
        if isNotANumber(char) || index == line.endIndex - 1,
        let unwrappedCurrent = currentNumber
      {
        let intOfCurrent = Int(unwrappedCurrent)!

        foundNumbers.append(PartNumber(number: intOfCurrent, isValid: currentIsValid))
        currentNumber = nil
        currentIsValid = false
      }
    }

      print(foundNumbers)
    return foundNumbers
  }
    
    func isNotANumber(_ char: Character) -> Bool {
        !"0123456789".contains(char)
    }

  func areAnySymbolsAdjacent(
    line: [Character], lineAbove: [Character], lineBelow: [Character], position: Int
  ) -> Bool {
    for i in position - 1...position + 1 {

      if !isDigitOrDot(lineAbove[safe: i] ?? ".") {
        return true
      }
      if !isDigitOrDot(line[safe: i] ?? ".") {
        return true
      }
      if !isDigitOrDot(lineBelow[safe: i] ?? ".") {
        return true
      }
    }
    return false
  }

  func isDigitOrDot(_ char: Character) -> Bool {
    return ".0123456789".contains(char)
  }
}

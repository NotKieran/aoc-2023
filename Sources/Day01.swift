import Algorithms

struct Day01: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
  var entities: [String] {
      data.split(separator: "\n").map({String($0)})
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
      var calibrationValues: [Int] = []
      
      entities.forEach({ line in
          if !line.isEmpty {
              calibrationValues.append(getCalibrartionValue(line: line))
          }
      })
      return calibrationValues.reduce(0, +)
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
      var calibrationValues: [Int] = []
      
      entities.forEach({ line in
          if !line.isEmpty {
              calibrationValues.append(getCalibrartionValue(line: line, shouldReplaceWrittenDigits: true))
          }
      })
      return calibrationValues.reduce(0, +)
      
  }
}

extension Day01 {
    func getCalibrartionValue(line: String, shouldReplaceWrittenDigits: Bool = false) -> Int {
        var numberLine = line
        if shouldReplaceWrittenDigits {
            numberLine = replaceWrittenDigits(line: line)
        }
        let numerics = numberLine.filter("0123456789".contains)
        let firstDigit = numerics.first!
        let lastDigit = numerics.last!
        let calibrationValue = Int("\(firstDigit)\(lastDigit)")
        return calibrationValue!
    }
    
    func replaceWrittenDigits(line: String) -> String {
        return line
            .replacingOccurrences(of: "one", with: "one1one")
            .replacingOccurrences(of: "two", with: "two2two")
            .replacingOccurrences(of: "three", with: "three3three")
            .replacingOccurrences(of: "four", with: "four4four")
            .replacingOccurrences(of: "five", with: "five5five")
            .replacingOccurrences(of: "six", with: "six6six")
            .replacingOccurrences(of: "seven", with: "seven7seven")
            .replacingOccurrences(of: "eight", with: "eight8eight")
            .replacingOccurrences(of: "nine", with: "nine9nine")
    }
}

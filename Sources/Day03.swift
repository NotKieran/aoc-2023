import Algorithms

struct CoOrd: Equatable, Hashable {
    let x: Int
    let y: Int
}

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
      var gearedParts: [GearedPart] = []
      for (index, line) in entities.enumerated() {
          gearedParts.append(
          contentsOf: findGearsWithPosition(
            line: line, lineAbove: entities[safe: index - 1] ?? [],
            lineBelow: entities[safe: index + 1] ?? [], lineY: index))
      }
      
      let validGearLocations = getValidGearLocations(gearedParts: gearedParts)
      
      var ratios: [Int] = []
      
      validGearLocations.forEach({ gearLocation in
          let parts = gearedParts.filter({ $0.gearLocation == gearLocation}).map({$0.number})
          ratios.append(parts.reduce(1) { $0 * $1 })
      })
    
      print(ratios)
      return ratios.reduce(0, +)
  }
}

struct PartNumber {
  let number: Int
  let isValid: Bool
}

struct GearedPart {
    let number: Int
    let gearLocation: CoOrd
}

extension Day03 {
    
    func findGearsWithPosition(line: [Character], lineAbove: [Character], lineBelow: [Character], lineY: Int)
      -> [GearedPart]
    {
      var foundNumbers: [GearedPart] = []
      var currentNumber: String? = nil
        var currentGearLocation: CoOrd? = nil

      for (index, char) in line.enumerated() {
          
          if char.isNumber {
            if currentNumber == nil {
              currentNumber = ""
            }
            if currentGearLocation == nil {
                currentGearLocation = areAnyGearsAdjacent(
                line: line, lineAbove: lineAbove, lineBelow: lineBelow, position: index, lineY: lineY)
            }
            currentNumber?.append(char)
          }
          
          if isNotANumber(char) || index == line.endIndex - 1,
          let unwrappedCurrentNumber = currentNumber
        {
          let intOfCurrent = Int(unwrappedCurrentNumber)!

              if let unwrappedCurrentGearLocation = currentGearLocation {
                  foundNumbers.append(GearedPart(number: intOfCurrent, gearLocation: unwrappedCurrentGearLocation))
              }

          currentNumber = nil
              currentGearLocation = nil
        }
      }
      return foundNumbers
    }
    
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
    
    func areAnyGearsAdjacent(
        line: [Character], lineAbove: [Character], lineBelow: [Character], position: Int, lineY: Int
    ) -> CoOrd? {
      for i in position - 1...position + 1 {
        if isGear(lineAbove[safe: i] ?? ".") {
            return CoOrd(x:i,y:lineY - 2)
        }
        if isGear(line[safe: i] ?? ".") {
            return CoOrd(x:i,y:lineY - 1)
        }
        if isGear(lineBelow[safe: i] ?? ".") {
            return CoOrd(x:i,y:lineY)
        }
      }
      return nil
    }

  func isDigitOrDot(_ char: Character) -> Bool {
    return ".0123456789".contains(char)
  }
    
    func isGear(_ char: Character) -> Bool {
      return "*".contains(char)
    }
    
    func getValidGearLocations(gearedParts: [GearedPart]) -> [CoOrd] {
        var gears: [CoOrd: Int] = [:]
        
        gearedParts.forEach({ part in
            if let partCount = gears[part.gearLocation] {
                gears[part.gearLocation] = partCount + 1
            } else {
                gears[part.gearLocation] = 1
            }
        })
        
        return gears.filter({$0.value == 2}).map({$0.key})
    }
}

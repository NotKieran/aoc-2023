import Algorithms

struct Game {
    let id: Int
    let isValid: Bool
    let minRed: Int
    let minGreen: Int
    let minBlue: Int
    let power: Int
}

struct Day02: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String

  // Splits input data into its component parts and convert from string.
    var entities: [String] {
        data.split(separator: "\n").map({String($0)})
    }
    
    let maxRed = 12
    let maxGreen = 13
    let maxBlue = 14

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
      var validGameIds: [Int] = []
      entities.forEach({ line in
          if !line.isEmpty {
              let game = isGameValid(game: line)
              if game.isValid {
                  validGameIds.append(game.id)
              }
          }
      })
      return validGameIds.reduce(0, +)
  }

  // Replace this with your solution for the second part of the day's challenge.
  func part2() -> Any {
      var validGameIds: [Int] = []
      entities.forEach({ line in
          if !line.isEmpty {
              let game = isGameValid(game: line)
              validGameIds.append(game.power)
          }
      })
      return validGameIds.reduce(0, +)
  }
}

extension Day02 {
    func isGameValid(game: String) -> Game {
        let id = game.getGameId()
        var isValid = true
        var minRed = 0
        var minGreen = 0
        var minBlue = 0
        
        
        let handfuls = game.getArrayOfHandfuls()
        handfuls.forEach({ handful in
            let draws = handful.components(separatedBy: ",")
            draws.forEach({ draw in
                if draw.contains("red") {
                    let currentRed = Int(draw.filter("0123456789".contains))!
                    if currentRed > minRed {
                        minRed = currentRed
                    }
                    if currentRed > maxRed {
                        isValid = false
                    }
                } else if draw.contains("green") {
                    let currentGreen = Int(draw.filter("0123456789".contains))!
                    if  currentGreen > minGreen {
                        minGreen = currentGreen
                    }
                    if currentGreen > maxGreen {
                        isValid = false
                    }
                } else if draw.contains("blue") {
                    let currentBlue = Int(draw.filter("0123456789".contains))!
                    if
                       currentBlue > minBlue {
                        minBlue = currentBlue
                    }
                    if currentBlue > maxBlue {
                        isValid = false
                    }
                }

                })
        })
        
        let power = minRed * minGreen * minBlue
        
        return Game(id: id, isValid: isValid, minRed: minRed, minGreen: minGreen, minBlue: minBlue, power: power)
    }
}

extension String {
    func getGameId() -> Int {
        let noGame = self.dropFirst("Game ".count)
        let splitString = noGame.components(separatedBy: ":")
        return Int(String(splitString.first!))!
    }
    
    func getArrayOfHandfuls() -> [String] {
        let colonSplit = self.components(separatedBy: ":")
        let handfulSplit = colonSplit.last!.components(separatedBy: ";")
        return handfulSplit
    }
}

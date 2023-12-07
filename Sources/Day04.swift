import Algorithms
import Parsing

struct ScratchCard {
    let id: Int
    let winningNumbers: [Int]
    let numbersOnCard: [Int]
    
    var value: Int {
        let winningSet = Set(winningNumbers)
        let cardNumberSet = Set(numbersOnCard)
            
        let commonNumbersCount = winningSet.intersection(cardNumberSet).count
        if commonNumbersCount > 0 {
            let order = commonNumbersCount - 1
            return 2 ** order
        } else {
            return 0
        }
    }
}

struct ScratchCardParser: Parser {
        var body: some Parser<Substring, ScratchCard> {
          Parse(ScratchCard.init(id:winningNumbers:numbersOnCard:)) {
              "Card"
              Whitespace()

                  Int.parser()
              ":"
              Whitespace()
              Many {
                Int.parser()
              } separator: {
                  Whitespace()
              } terminator: {
                  Whitespace()
                  "|"
                  Whitespace()
                }
              Many {
                Int.parser()
              } separator: {
                  Whitespace()
              }
          }
        }
      }

struct ScratchCardsParser: Parser {
        var body: some Parser<Substring, [ScratchCard]> {
          Many {
              ScratchCardParser()
          } separator: {
            "\n"
          } terminator: {
              "\n\n"
          }
        }
      }

struct Day04: AdventDay {
  // Save your data in a corresponding text file in the `Data` directory.
  var data: String
    
  // Splits input data into its component parts and convert from string.
  var entities: [ScratchCard] {
      try! ScratchCardsParser().parse(data)
  }

  // Replace this with your solution for the first part of the day's challenge.
  func part1() -> Any {
      return entities.map({ $0.value}).reduce(0, +)
  }

  func part2() -> Any {
      return entities
  }
}

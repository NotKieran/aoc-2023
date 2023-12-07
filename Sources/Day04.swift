import Algorithms
import Parsing

struct ScratchCard {
    let id: Int
    let winningNumbers: [Int]
    let numbersOnCard: [Int]
    
    var matchingNumbers: Int {
        let winningSet = Set(winningNumbers)
        let cardNumberSet = Set(numbersOnCard)
            
        return winningSet.intersection(cardNumberSet).count
    }
    
    var value: Int {
        if matchingNumbers > 0 {
            let order = matchingNumbers - 1
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

    /// 5604889 Too low
  func part2() -> Any {
      typealias Id = Int
      typealias InstanceCount = Int
      
      var cardInstances: [Id:InstanceCount] = [:]
      
      for i in 1...entities.count {
          cardInstances[i] = 1
      }
      
      for card in entities {
          let cardCount = cardInstances[card.id]
          
          if card.matchingNumbers > 0 {
              for i in 1...card.matchingNumbers {
                  let id = i + card.id
                  if id < entities.endIndex + 1 {
                      cardInstances[id] = cardInstances[id]! + cardCount!
                  }
              }
          }
      }
      
      return cardInstances.values.reduce(0, +)
  }
}

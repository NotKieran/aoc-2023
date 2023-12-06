import XCTest

@testable import AdventOfCode

// Make a copy of this file for every day to ensure the provided smoke tests
// pass.
final class Day03Tests: XCTestCase {
  // Smoke test data provided in the challenge question
  let testData = """
    12.......*..
    +.........34
    .......-12..
    ..78........
    ..*....60...
    78.........9
    .5.....23..$
    8...90*12...
    ............
    2.2......12.
    .*.........*
    1.1..503+.56
    """

  func testPart1() throws {
    let challenge = Day03(data: testData)
    XCTAssertEqual(String(describing: challenge.part1()), "925")
  }

  func testPart2() throws {
    let challenge = Day03(data: testData)
    XCTAssertEqual(String(describing: challenge.part2()), "4361")
  }
}

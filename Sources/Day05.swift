import Algorithms
import Parsing


typealias Map = [[Int]]

struct MapParser: Parser {
    var body: some Parser<Substring,  Map> {
        Many {
            Many {
                Int.parser()
            } separator: {
                Whitespace()
            }
        } separator: {
            "\n"
        } terminator: {
            "\n\n"
        }
    }}

struct Almanac {
    let seeds: [Int]
    let seedToSoil: Map
    let soilToFert: Map
    let fertToWater: Map
    let waterToLight: Map
    let lightToTemp: Map
    let tempToHumid: Map
    let humidToLocation: Map
}
struct AlmanacParser: Parser {
    var body: some Parser<Substring, Almanac> {
        Parse(
            Almanac.init(
                seeds:seedToSoil:soilToFert:fertToWater:waterToLight:lightToTemp:tempToHumid:
                    humidToLocation:)
        ) {
            "seeds:"
            Whitespace()
            Many {
                Int.parser()
            } separator: {
                Whitespace()
            } terminator: {
                "\n\n"
            }
            "seed-to-soil map:"
            MapParser()
            "soil-to-fertilizer map:\n"
            MapParser()
            "fertilizer-to-water map:\n"
            MapParser()
            "water-to-light map:\n"
            MapParser()
            "light-to-temperature map:\n"
            MapParser()
            "temperature-to-humidity map:\n"
            MapParser()
            "humidity-to-location map:\n"
            MapParser()
        }
    }
}

struct Day05: AdventDay {
    // Save your data in a corresponding text file in the `Data` directory.
    var data: String
    
    // Splits input data into its component parts and convert from string.
    var almanac: Almanac {
        try! AlmanacParser().parse(data)
    }
    
    // Replace this with your solution for the first part of the day's challenge.
    func part1() -> Any {
        // Calculate the sum of the first set of input data
        print(almanac)
        return almanac
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        // Sum the maximum entries in each set of data
        return almanac
    }
}

import Algorithms
import Parsing


struct MapLine {
    let destination: Int;
    let source: Int;
    let range: Int
}

typealias Map = [MapLine]

struct MapLineParser: Parser {
    var body: some Parser<Substring,  MapLine> {
        Parse(MapLine.init(destination:source:range:))
        {
            Int.parser()
            Whitespace()
            Int.parser()
            Whitespace()
            Int.parser()
        }}
}

struct MapParser: Parser {
    var body: some Parser<Substring,  Map> {
        Many {
            MapLineParser()
        } separator: {
            "\n"
        } terminator: {
            "\n"
        }
    }
}

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
            "seed-to-soil map:\n"
            MapParser()
            Whitespace()
            "soil-to-fertilizer map:\n"
            MapParser()
            Whitespace()
            "fertilizer-to-water map:\n"
            MapParser()
            Whitespace()
            "water-to-light map:\n"
            MapParser()
            Whitespace()
            "light-to-temperature map:\n"
            MapParser()
            Whitespace()
            "temperature-to-humidity map:\n"
            MapParser()
            Whitespace()
            "humidity-to-location map:\n"
            MapParser()
            Whitespace()
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

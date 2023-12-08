import Algorithms
import Parsing


struct MapLine {
    let destination: Int;
    let source: Int;
    let range: Int
    
    private var sourceRange: ClosedRange<Int> {
        source...source+range
    }
    
    private var destinationRange: ClosedRange<Int> {
        destination...destination+range
    }
    
    func map(number: Int) -> Int? {
        guard sourceRange.contains(number) else {
            return nil
        }
        return number + destination - source
    }
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
    
    var mapSeedsToSoil: [Int] {
        var mapping: [Int:Int] = [:]
        for seed in seeds {
            mapping[seed] = seed
            seedToSoil.forEach({ mapLine in
                if let mappedValue = mapLine.map(number: seed) {
                    mapping[seed] = mappedValue
                }
            })
        }
        return Array(mapping.values)
    }
    
    func map(this items: [Int], from sourceMap: Map) -> [Int] {
        var mapping: [Int:Int] = [:]
        for thing in items {
            mapping[thing] = thing
            sourceMap.forEach({ mapLine in
                if let mappedValue = mapLine.map(number: thing) {
                    mapping[thing] = mappedValue
                }
            })
        }
        return Array(mapping.values)
    }
    
    var locations: [Int] {
        let soil = map(this: seeds, from: seedToSoil)
        let fert = map(this: soil, from: soilToFert)
        let water = map(this: fert, from: fertToWater)
        let light = map(this: water, from: waterToLight)
        let temp = map(this: light, from: lightToTemp)
        let humid = map(this: temp, from: tempToHumid)
        return map(this: humid, from: humidToLocation)
    }
    
    var partTwoSeeds: [Int] {
        let seedPairs = seeds.chunked(into: 2)
        var allSeeds: [Int] = []
        for pair in seedPairs {
            allSeeds += Array(pair[0]..<pair[0]+pair[1])
        }
        return allSeeds
    }
    
    var partTwoLocations: [Int] {
        let soil = map(this: partTwoSeeds, from: seedToSoil)
        let fert = map(this: soil, from: soilToFert)
        let water = map(this: fert, from: fertToWater)
        let light = map(this: water, from: waterToLight)
        let temp = map(this: light, from: lightToTemp)
        let humid = map(this: temp, from: tempToHumid)
        return map(this: humid, from: humidToLocation)
    }
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
        return almanac.locations.min()!
    }
    
    // Replace this with your solution for the second part of the day's challenge.
    func part2() -> Any {
        return almanac.partTwoLocations.min()!
    }
}

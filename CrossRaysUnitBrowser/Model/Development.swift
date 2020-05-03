struct Developments: Decodable {
    let developments: [Development]
}

struct Development: Decodable {
    struct DevelopInto: Decodable {
        let level: String
        let unitName: String
    }

    let baseUnitName: String
    let developIntos: [DevelopInto]
}

struct Develop {
    enum Direction {
        case into
        case from
    }

    let unit: Unit
    let level: String
    let direction: Direction
}

extension Develop: Identifiable {
    var id: String { unit.name }
}

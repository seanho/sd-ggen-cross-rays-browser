import Foundation

extension JSON {
    struct Units: Decodable {
        let units: [Unit]
    }

    struct Unit: Decodable {
        struct Terrain: Decodable {
            let space: String
            let atmospheric: String
            let ground: String
            let surface: String
            let underwater: String
        }

        let release: String
        let series: String
        let name: String
        let iconName: String?
        let iconUrl: String?
        let cost: Int?
        let exp: Int?
        let size: String
        let hp: Int?
        let en: Int?
        let attack: Int?
        let defence: Int?
        let mobility: Int?
        let movement: Int?
        let terrain: Terrain?
        let sfs: Bool
        let defenceSupport: Bool
    }

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
}

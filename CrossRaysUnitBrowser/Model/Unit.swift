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

    var iconKey: String {
        iconName?.replacingOccurrences(of: ".png", with: "") ?? ""
    }
}

extension Unit: Identifiable {
    var id: String { name }
}

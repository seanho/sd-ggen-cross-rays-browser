class Unit {
    class Terrain {
        let space: String
        let atmospheric: String
        let ground: String
        let surface: String
        let underwater: String

        init(json: JSON.Unit.Terrain) {
            self.space = json.space
            self.atmospheric = json.atmospheric
            self.ground = json.ground
            self.surface = json.surface
            self.underwater = json.underwater
        }
    }

    let series: Series
    let name: String
    let iconName: String
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
    var developIntos: [Development] = []
    var developFroms: [Development] = []

    init(series: Series, json: JSON.Unit) {
        self.series = series
        self.name = json.name
        self.iconName = json.iconName?.replacingOccurrences(of: ".png", with: "") ?? ""
        self.cost = json.cost
        self.exp = json.exp
        self.size = json.size
        self.hp = json.hp
        self.en = json.en
        self.attack = json.attack
        self.defence = json.defence
        self.mobility = json.mobility
        self.movement = json.movement
        self.terrain = json.terrain.map(Terrain.init)
        self.sfs = json.sfs
        self.defenceSupport = json.defenceSupport
    }
}

extension Unit: Identifiable {
    var id: String { name }
}

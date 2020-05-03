class Development {
    let unit: Unit
    let level: String

    init(unit: Unit, level: String) {
        self.unit = unit
        self.level = level
    }
}

extension Development: Identifiable {
    var id: String { unit.name }
}

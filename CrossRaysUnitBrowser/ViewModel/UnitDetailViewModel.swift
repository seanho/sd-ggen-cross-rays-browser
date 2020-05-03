struct UnitDetailViewModel {
    static func make(unit: Unit, dataRepo: DataRepo) -> Self {
        let developIntos = dataRepo.developments[unit.name]?.developIntos
            .compactMap { developInto -> Develop? in
                if let intoUnit = dataRepo.units[developInto.unitName] {
                    return Develop(unit: intoUnit, level: developInto.level, direction: .into)
                } else {
                    return nil
                }
            } ?? []

        let developFroms = dataRepo.developments.compactMap { development -> Develop? in
            if let fromUnit = dataRepo.units[development.baseUnitName],
                let developInto = development.developIntos.first(where: { $0.unitName == unit.name }) {
                return Develop(unit: fromUnit, level: developInto.level, direction: .from)
            } else {
                return nil
            }
        }

        return UnitDetailViewModel(
            unit: unit,
            developIntos: developIntos,
            developFroms: developFroms
        )
    }

    let unit: Unit
    let developIntos: [Develop]
    let developFroms: [Develop]
}

extension Array where Element == Unit {
    subscript(name: String) -> Element? {
        self.first { $0.name == name }
    }
}

extension Array where Element == Development {
    subscript(name: String) -> Element? {
        self.first { $0.baseUnitName == name }
    }
}

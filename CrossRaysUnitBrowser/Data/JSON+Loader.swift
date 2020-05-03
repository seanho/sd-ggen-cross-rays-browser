import Foundation

extension JSON {
    static func loadUnits() -> [Unit] {
        let dataURL = Bundle.main.url(forResource: "units", withExtension: "json")!
        let data = try! Data(contentsOf: dataURL)
        let units = try! JSONDecoder().decode(Units.self, from: data)
        return units.units
    }

    static func loadDevelopments() -> [Development] {
        let dataURL = Bundle.main.url(forResource: "developments", withExtension: "json")!
        let data = try! Data(contentsOf: dataURL)
        let developments = try! JSONDecoder().decode(Developments.self, from: data)
        return developments.developments
    }
}

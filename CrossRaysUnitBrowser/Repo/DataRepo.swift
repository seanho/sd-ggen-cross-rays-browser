import Combine
import Foundation

class DataRepo: ObservableObject {
    let series: [Series]
    let units: [Unit]
    let developments: [Development]

    init() {
        series = Series.crossRaysUnits
        units = Self.loadUnits().units
        developments = Self.loadDevelopments().developments
    }

    static func loadUnits() -> Units {
        let dataURL = Bundle.main.url(forResource: "units", withExtension: "json")!
        let data = try! Data(contentsOf: dataURL)
        let units = try! JSONDecoder().decode(Units.self, from: data)
        return units
    }

    static func loadDevelopments() -> Developments {
        let dataURL = Bundle.main.url(forResource: "developments", withExtension: "json")!
        let data = try! Data(contentsOf: dataURL)
        let developments = try! JSONDecoder().decode(Developments.self, from: data)
        return developments
    }
}

struct UnitListViewModel {
    static func make(series: Series?, dataRepo: DataRepo) -> Self {
        UnitListViewModel(
            title: series?.title ?? "All",
            units: series.map { s in dataRepo.units.filter({ $0.series == s.id }) } ?? dataRepo.units
        )
    }

    let title: String
    let units: [Unit]
}

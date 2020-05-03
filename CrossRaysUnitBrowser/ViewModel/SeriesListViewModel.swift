struct SeriesListViewModel {
    static func make(dataRepo: DataRepo) -> Self {
        SeriesListViewModel(seriesList: dataRepo.series)
    }

    let seriesList: [Series]
}

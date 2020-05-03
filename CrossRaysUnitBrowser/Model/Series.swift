class Series {
    let title: String
    let logoName: String
    var units: [Unit] = []

    init(title: String, logoName: String) {
        self.title = title
        self.logoName = logoName
    }
}

extension Series: Identifiable {
    var id: String { title }
}

import SwiftUI

struct SeriesListView: View {
    @EnvironmentObject var dataRepo: DataRepo
    let viewModel: SeriesListViewModel

    var body: some View {
        let viewModel = SeriesListViewModel(seriesList: dataRepo.series)

        return NavigationView {
            List {
                ForEach(viewModel.seriesList) { series in
                    NavigationLink(destination: UnitListView(viewModel: .make(series: series, dataRepo: self.dataRepo))) {
                        SeriesRowView(series: series)
                    }
                }
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
            }
            .navigationBarTitle(Text("SD Gundam G Generation Cross Rays"), displayMode: .inline)
        }
    }
}

struct SeriesRowView: View {
    let series: Series

    var body: some View {
        HStack {
            Image(series.logoName)
                .resizable()
                .scaledToFit()
                .frame(width: 120, height: 80)
            Text(series.title)
        }
    }
}

struct SeriesListView_Previews: PreviewProvider {
    static let dataRepo = DataRepo()

    static var previews: some View {
        SeriesListView(viewModel: .make(dataRepo: dataRepo))
            .environmentObject(dataRepo)
    }
}

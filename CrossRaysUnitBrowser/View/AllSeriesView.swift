import SwiftUI

struct AllSeriesView: View {
    let allSeries: [Series]

    var body: some View {
        NavigationView {
            List {
                ForEach(allSeries) { aSeries in
                    NavigationLink(destination: UnitListView(title: aSeries.title, units: aSeries.units)) {
                        SeriesRowView(series: aSeries)
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
            Text(LocalizedStringKey(series.title))
                .lineLimit(2)
        }
    }
}

struct AllSeriesView_Previews: PreviewProvider {
    static let series = ModelGraph().build()

    static var previews: some View {
        AllSeriesView(allSeries: series)
    }
}

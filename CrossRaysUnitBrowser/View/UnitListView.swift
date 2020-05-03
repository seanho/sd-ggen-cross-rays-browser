import SwiftUI

struct UnitListView: View {
    @EnvironmentObject var dataRepo: DataRepo
    @State var selectedUnit: Unit?
    let viewModel: UnitListViewModel

    var body: some View {
        List {
            ForEach(viewModel.units) { unit in
                UnitRowView(unit: unit)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
                    .onTapGesture {
                        self.selectedUnit = unit
                    }
            }
        }
        .navigationBarTitle(Text(viewModel.title), displayMode: .inline)
        .sheet(item: $selectedUnit) {
            UnitDetailView(viewModel: .make(unit: $0, dataRepo: self.dataRepo))
                .environmentObject(self.dataRepo)
        }
    }
}

struct UnitRowView: View {
    let unit: Unit

    var body: some View {
        HStack {
            Image(unit.iconKey)
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 48)
                .background(Color(UIColor.systemGray5))
            Text(unit.name)
        }
    }
}

struct UnitListView_Previews: PreviewProvider {
    static let dataRepo = DataRepo()

    static var previews: some View {
        NavigationView {
            UnitListView(viewModel: .make(series: dataRepo.series.first, dataRepo: dataRepo))
                .environmentObject(dataRepo)
        }
    }
}

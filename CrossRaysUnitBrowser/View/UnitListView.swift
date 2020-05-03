import SwiftUI

struct UnitListView: View {
    let title: String
    let units: [Unit]

    @State var selectedUnit: Unit?

    var body: some View {
        List {
            ForEach(units) { unit in
                UnitRowView(unit: unit)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 12))
                    .onTapGesture {
                        self.selectedUnit = unit
                    }
            }
        }
        .navigationBarTitle(Text(title), displayMode: .inline)
        .sheet(item: $selectedUnit) {
            UnitDetailView(unit: $0)
        }
    }
}

struct UnitRowView: View {
    let unit: Unit

    var body: some View {
        HStack {
            Image(unit.iconName)
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 48)
                .background(Color(UIColor.systemGray5))
            Text(unit.name)
        }
    }
}

struct UnitListView_Previews: PreviewProvider {
    static let units = JSON.loadUnits().prefix(5).map { Unit(series: Series(title: "", logoName: ""), json: $0) }

    static var previews: some View {
        NavigationView {
            UnitListView(title: "Gundams", units: units)
        }
    }
}

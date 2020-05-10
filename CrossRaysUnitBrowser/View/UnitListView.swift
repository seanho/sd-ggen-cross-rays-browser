import SwiftUI

struct UnitListView: View {
    let title: String
    let units: [Unit]

    @State var selectedUnit: Unit?

    var body: some View {
        List {
            ForEach(units) { unit in
                UnitRowView(unit: unit)
                    .listRowInsets(EdgeInsets(top: 4, leading: 0, bottom: 4, trailing: 20))
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
            UnitIconView(unit.iconName)
            Text(unit.name)
                .foregroundColor(Color.white)
        }
    }
}

struct UnitIconView: View {
    let iconName: String

    init(_ iconName: String) {
        self.iconName = iconName
    }

    var body: some View {
        Image(iconName)
            .resizable()
            .scaledToFit()
            .frame(width: 96, height: 48)
            .background(Color(UIColor.systemGray5))
    }
}

struct UnitListView_Previews: PreviewProvider {
    static let series = ModelGraph().build()

    static var previews: some View {
        NavigationView {
            UnitListView(title: "Gundams", units: series.first!.units)
        }
        .environment(\.colorScheme, .dark)
    }
}

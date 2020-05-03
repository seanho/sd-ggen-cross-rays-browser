import SwiftUI

struct UnitDetailView: View {
    let unit: Unit

    @State var selectedUnit: Unit?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Image(unit.iconName)
                            .resizable()
                            .background(Color(UIColor.systemGray5))
                            .frame(width: 96, height: 48)

                        VStack {
                            AttributeView(label: "Cost", value: unit.cost)
                            AttributeView(label: "EXP", value: unit.exp)
                            AttributeView(label: "HP", value: unit.hp)
                            AttributeView(label: "EN", value: unit.en)
                            AttributeView(label: "Size", value: unit.size)
                            AttributeView(label: "Atk", value: unit.attack)
                            AttributeView(label: "Def", value: unit.defence)
                            AttributeView(label: "Mob", value: unit.mobility)
                            AttributeView(label: "Mov", value: unit.movement)
                        }
                    }
                    .padding(.top, 16)

                    if !unit.developIntos.isEmpty {
                        Divider()

                        ForEach(unit.developIntos) { development in
                            UnitDevelopView(unit: self.unit, development: development, isDevelopInto: true)
                                .onTapGesture {
                                    self.selectedUnit = development.unit
                                }
                        }
                    }

                    if !unit.developFroms.isEmpty {
                        Divider()

                        ForEach(unit.developFroms) { development in
                            UnitDevelopView(unit: self.unit, development: development, isDevelopInto: false)
                                .onTapGesture {
                                    self.selectedUnit = development.unit
                                }
                        }
                    }
                }
            }
            .navigationBarTitle(Text(unit.name), displayMode: .inline)
        }
        .sheet(item: $selectedUnit) {
            UnitDetailView(unit: $0)
        }
    }
}

struct AttributeView: View {
    let label: String
    let value: String

    init(label: String, value: String?) {
        self.label = label
        self.value = value ?? "-"
    }

    init(label: String, value: Int?) {
        self.label = label
        self.value = value.map(String.init) ?? "-"
    }

    init(label: String, value: Bool) {
        self.label = label
        self.value = value ? "Yes" : "No"
    }

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .frame(width: 60, height: 20, alignment: .trailing)

            Text(value)
                .font(.subheadline)
                .frame(width: 120, height: 20, alignment: .leading)
        }
    }
}

struct UnitDevelopView: View {
    let unit: Unit
    let development: Development
    let isDevelopInto: Bool

    var body: some View {
        HStack {
            if isDevelopInto {
                ZStack(alignment: .bottomTrailing) {
                    Image(unit.iconName)
                    .resizable()
                    .background(Color(UIColor.systemGray5))
                    .frame(width: 96, height: 48)

                    Text("Lv\(development.level)")
                        .font(.caption)
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .background(Color(UIColor.systemGray))
                }

                Text("➡️")

                Image(development.unit.iconName)
                    .resizable()
                    .background(Color(UIColor.systemGray5))
                    .frame(width: 96, height: 48)
            } else {
                Image(unit.iconName)
                    .resizable()
                    .background(Color(UIColor.systemGray5))
                    .frame(width: 96, height: 48)

                Text("⬅️")

                ZStack(alignment: .bottomTrailing) {
                    Image(development.unit.iconName)
                        .resizable()
                        .background(Color(UIColor.systemGray5))
                        .frame(width: 96, height: 48)

                    Text("Lv\(development.level)")
                        .font(.caption)
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .background(Color(UIColor.systemGray))
                }
            }

            Text(development.unit.name)
        }
    }
}

struct UnitDetailView_Previews: PreviewProvider {
    static let unit = JSON.loadUnits().first.map { Unit(series: Series(title: "", logoName: ""), json: $0) }!

    static var previews: some View {
        NavigationView {
            UnitDetailView(unit: unit)
        }
    }
}

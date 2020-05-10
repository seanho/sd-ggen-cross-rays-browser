import SwiftUI

struct UnitDetailView: View {
    let unit: Unit

    @State var selectedUnit: Unit?

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    HStack(alignment: .top, spacing: 20) {
                        VStack(alignment: .leading, spacing: 8) {
                            Image(unit.iconName)
                                .resizable()
                                .background(Color(UIColor.systemGray5))
                                .frame(width: 96, height: 48)

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Cost")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text(unit.cost.map(String.init) ?? "-")
                                    .font(.subheadline)
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text("Size")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text(unit.size)
                                    .font(.subheadline)
                            }

                            VStack(alignment: .leading, spacing: 2) {
                                Text("EXP")
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text(unit.exp.map(String.init) ?? "-")
                                    .font(.subheadline)
                            }
                        }

                        VStack(spacing: 8) {
                            UnitStatsView(label: "HP", value: unit.hp) {
                                ProgressView(value: Float(unit.hp ?? 0), maximum: Float(UnitStats.maxHP), startColor: Color(UIColor.systemGreen.darken()), endColor: Color(UIColor.systemGreen.lighten()))
                                    .frame(height: 6)
                            }
                            UnitStatsView(label: "EN", value: unit.en) {
                                ProgressView(value: Float(unit.en ?? 0), maximum: Float(UnitStats.maxEN), startColor: Color(UIColor.systemOrange.darken()), endColor: Color(UIColor.systemOrange.lighten()))
                                    .frame(height: 6)
                            }
                            UnitStatsView(label: "ATK", value: unit.attack) {
                                ProgressView(value: Float(unit.attack ?? 0), maximum: Float(UnitStats.maxAttack))
                                    .frame(height: 6)
                            }
                            UnitStatsView(label: "DEF", value: unit.defence) {
                                ProgressView(value: Float(unit.defence ?? 0), maximum: Float(UnitStats.maxDefence))
                                    .frame(height: 6)
                            }
                            UnitStatsView(label: "MOB", value: unit.mobility) {
                                ProgressView(value: Float(unit.mobility ?? 0), maximum: Float(UnitStats.maxMobility))
                                    .frame(height: 6)
                            }
                            UnitStatsView(label: "MOV", value: unit.movement) {
                                SegmentedProgressView(value: unit.movement ?? 0, maximum: 8)
                                    .frame(height: 6)
                            }
                        }
                    }
                    .padding(.top, 16)

                    if unit.terrain != nil {
                        Divider()
                        UnitTerrainView(terrain: unit.terrain!)
                    }

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
                .padding(20)
            }
            .navigationBarTitle(Text(unit.name), displayMode: .inline)
        }
        .sheet(item: $selectedUnit) {
            UnitDetailView(unit: $0)
        }
    }
}

struct UnitTerrainView: View {
    let terrain: Unit.Terrain

    var body: some View {
        HStack(spacing: 4) {
            UnitTerrainItemView(label: "Space", value: self.terrain.space)
            UnitTerrainItemView(label: "Atmospheric", value: self.terrain.atmospheric)
            UnitTerrainItemView(label: "Ground", value: self.terrain.ground)
            UnitTerrainItemView(label: "Surface", value: self.terrain.surface)
            UnitTerrainItemView(label: "Underwater", value: self.terrain.underwater)
        }
    }
}

struct UnitTerrainItemView: View {
    let label: String
    let value: String

    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text(label)
                .font(.caption)
                .lineLimit(1)
                .foregroundColor(value == "-" ? .secondary : .primary)
            Text(value)
                .font(.subheadline)
                .foregroundColor(value == "-" ? .secondary : .primary)
        }
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
}

struct UnitStatsView<Content: View>: View {
    let label: String
    let value: String
    let content: Content

    init(label: String, value: String, @ViewBuilder content: () -> Content) {
        self.label = label
        self.value = value
        self.content = content()
    }

    init(label: String, value: Int?, @ViewBuilder content: () -> Content) {
        self.label = label
        self.value = value.map(String.init) ?? ""
        self.content = content()
    }

    var body: some View {
        VStack(spacing: 2) {
            HStack {
                Text(label)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                Spacer()
                Text(value)
                    .font(.subheadline)
            }
            content
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
                Text("LV")
                    .font(Font.caption)
                    .foregroundColor(Color.white) +
                Text("\(development.level)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.yellow)

                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)

                Image(development.unit.iconName)
                    .resizable()
                    .background(Color(UIColor.systemGray5))
                    .frame(width: 96, height: 48)
                
            } else {
                Image(systemName: "arrow.left.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)

                Text("LV")
                    .font(Font.caption)
                    .foregroundColor(Color.white) +
                Text("\(development.level)")
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .foregroundColor(Color.yellow)

                Image(development.unit.iconName)
                    .resizable()
                    .background(Color(UIColor.systemGray5))
                    .frame(width: 96, height: 48)
            }

            Text(development.unit.name)
        }
    }
}

struct UnitDetailView_Previews: PreviewProvider {
    static let series = ModelGraph().build()

    static var previews: some View {
//        NavigationView {
            UnitDetailView(unit: series.first!.units.first!)
//        }
        .environment(\.colorScheme, .dark)
    }
}

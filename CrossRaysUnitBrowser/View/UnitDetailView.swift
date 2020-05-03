import SwiftUI

struct UnitDetailView: View {
    @EnvironmentObject var dataRepo: DataRepo
    @State var selectedUnit: Unit?
    let viewModel: UnitDetailViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        Image(viewModel.unit.iconKey)
                            .resizable()
                            .background(Color(UIColor.systemGray5))
                            .frame(width: 96, height: 48)

                        VStack {
                            AttributeView(label: "Cost", value: viewModel.unit.cost)
                            AttributeView(label: "EXP", value: viewModel.unit.exp)
                            AttributeView(label: "HP", value: viewModel.unit.hp)
                            AttributeView(label: "EN", value: viewModel.unit.en)
                            AttributeView(label: "Size", value: viewModel.unit.size)
                            AttributeView(label: "Atk", value: viewModel.unit.attack)
                            AttributeView(label: "Def", value: viewModel.unit.defence)
                            AttributeView(label: "Mob", value: viewModel.unit.mobility)
                            AttributeView(label: "Mov", value: viewModel.unit.movement)
                        }
                    }
                    .padding(.top, 16)

                    if !viewModel.developIntos.isEmpty {
                        Divider()

                        ForEach(viewModel.developIntos) { develop in
                            UnitDevelopView(unit: self.viewModel.unit, develop: develop)
                                .onTapGesture {
                                    self.selectedUnit = develop.unit
                                }
                        }
                    }

                    if !viewModel.developFroms.isEmpty {
                        Divider()

                        ForEach(viewModel.developFroms) { develop in
                            UnitDevelopView(unit: self.viewModel.unit, develop: develop)
                                .onTapGesture {
                                    self.selectedUnit = develop.unit
                                }
                        }
                    }
                }
            }
            .navigationBarTitle(Text(viewModel.unit.name), displayMode: .inline)
        }
        .sheet(item: $selectedUnit) {
            UnitDetailView(viewModel: .make(unit: $0, dataRepo: self.dataRepo))
                .environmentObject(self.dataRepo)
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
    let develop: Develop

    var body: some View {
        HStack {
            if develop.direction == .into {
                ZStack(alignment: .bottomTrailing) {
                    Image(unit.iconKey)
                    .resizable()
                    .background(Color(UIColor.systemGray5))
                    .frame(width: 96, height: 48)

                    Text("Lv\(develop.level)")
                        .font(.caption)
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .background(Color(UIColor.systemGray))
                }

                Text("➡️")

                Image(develop.unit.iconKey)
                    .resizable()
                    .background(Color(UIColor.systemGray5))
                    .frame(width: 96, height: 48)
            } else {
                Image(unit.iconKey)
                    .resizable()
                    .background(Color(UIColor.systemGray5))
                    .frame(width: 96, height: 48)

                Text("⬅️")

                ZStack(alignment: .bottomTrailing) {
                    Image(develop.unit.iconKey)
                        .resizable()
                        .background(Color(UIColor.systemGray5))
                        .frame(width: 96, height: 48)

                    Text("Lv\(develop.level)")
                        .font(.caption)
                        .foregroundColor(Color.white)
                        .padding(EdgeInsets(top: 2, leading: 4, bottom: 2, trailing: 4))
                        .background(Color(UIColor.systemGray))
                }
            }

            Text(develop.unit.name)
        }
    }
}

struct UnitDetailView_Previews: PreviewProvider {
    static let dataRepo = DataRepo()

    static var previews: some View {
        NavigationView {
            UnitDetailView(viewModel: .make(unit: dataRepo.units.first!, dataRepo: dataRepo))
                .environmentObject(dataRepo)
        }
    }
}

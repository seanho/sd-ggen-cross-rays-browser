struct ModelGraph {
    func build() -> [Series] {
        let series = allSeries()

        var unitsMap: [String: Unit] = [:]
        let jsonUnits = JSON.loadUnits()
        let jsonUnitsBySeries = Dictionary(grouping: jsonUnits, by: { $0.series })
        series.forEach { s in
            if let units = jsonUnitsBySeries[s.title] {
                s.units = units.map { Unit(series: s, json: $0) }
                s.units.forEach { unitsMap.updateValue($0, forKey: $0.id) }
            }
        }

        var intoMap: [String: [Development]] = [:]
        var fromMap: [String: [Development]] = [:]
        let jsonDevelopments = JSON.loadDevelopments()
        jsonDevelopments.forEach { jsonDevelopment in
            if let fromUnit = unitsMap[jsonDevelopment.baseUnitName] {
                jsonDevelopment.developIntos.forEach { developInto in
                    if let intoUnit = unitsMap[developInto.unitName] {
                        intoMap[fromUnit.name, default: []].append(Development(unit: intoUnit, level: developInto.level))
                        fromMap[intoUnit.name, default: []].append(Development(unit: fromUnit, level: developInto.level))
                    }
                }
            }
        }

        series.forEach { s in
            s.units.forEach { u in
                if let developments = intoMap[u.name] {
                    u.developIntos = developments
                }
                if let developments = fromMap[u.name] {
                    u.developFroms = developments
                }
            }
        }

        UnitStats.maxEN = jsonUnits.compactMap { $0.en }.max() ?? 1
        UnitStats.maxHP = jsonUnits.compactMap { $0.hp }.max() ?? 1
        UnitStats.maxExp = jsonUnits.compactMap { $0.exp }.max() ?? 1
        UnitStats.maxCost = jsonUnits.compactMap { $0.cost }.max() ?? 1
        UnitStats.maxAttack = jsonUnits.compactMap { $0.attack }.max() ?? 1
        UnitStats.maxDefence = jsonUnits.compactMap { $0.defence }.max() ?? 1
        UnitStats.maxMobility = jsonUnits.compactMap { $0.mobility }.max() ?? 1
        UnitStats.maxMovement = jsonUnits.compactMap { $0.movement }.max() ?? 8

        return series
    }

    private func allSeries() -> [Series] {
        /* Excluded DLC Series
         Series(title: "Mobile Fighter G Gundam", logoName: "logo_g_gundam"),
         Series(title: "After War Gundam X", logoName: "logo_x"),
         Series(title: "After War Gundam X NEXT PROLOGUE \"With you, if it's with you\"", logoName: "logo_x_next"),
         Series(title: "Turn A Gundam", logoName: "logo_turn_a"),
         Series(title: "Mobile Suit Gundam SEED Astray Princess of the Sky", logoName: "logo_seed_astray_top"),
         Series(title: "Mobile Suit Gundam AGE", logoName: "logo_age"),
         Series(title: "Reconguista in G", logoName: "logo_greco")
         */
        return [
            Series(title: "Mobile Suit Gundam Wing", logoName: "logo_w"),
            Series(title: "Mobile Suit Gundam Wing: Dual Story G-Unit", logoName: "logo_w_g_unit"),
            Series(title: "Mobile Suit Gundam Wing: Battlefield of Pacifists", logoName: "logo_w_bop"),
            Series(title: "Mobile Suit Gundam Wing: Endless Waltz Glory of Losers", logoName: "logo_w_ew_01"),
            Series(title: "Mobile Suit Gundam Wing: Endless Waltz", logoName: "logo_w_ew_02"),
            Series(title: "Mobile Suit Gundam SEED", logoName: "logo_seed"),
            Series(title: "Mobile Suit Gundam SEED MSV", logoName: "logo_seed_msv"),
            Series(title: "Mobile Suit Gundam SEED Astray", logoName: "logo_seed_astray"),
            Series(title: "Mobile Suit Gundam SEED Astray R", logoName: "logo_seed_astray_r"),
            Series(title: "Mobile Suit Gundam SEED Astray B", logoName: "logo_seed_astray_b"),
            Series(title: "Mobile Suit Gundam SEED X Astray", logoName: "logo_seed_x_astray"),
            Series(title: "Mobile Suit Gundam SEED Destiny", logoName: "logo_seed_destiny"),
            Series(title: "Mobile Suit Gundam SEED Destiny MSV", logoName: "logo_seed_destiny_msv"),
            Series(title: "Mobile Suit Gundam SEED Destiny Astray", logoName: "logo_seed_d_astray"),
            Series(title: "Mobile Suit Gundam SEED C.E.73 Stargazer", logoName: "logo_seed_stargazer"),
            Series(title: "Mobile Suit Gundam SEED C.E.73 Delta Astray", logoName: "logo_seed_del_astray"),
            Series(title: "Mobile Suit Gundam SEED Frame Astrays", logoName: "logo_seed_frame_astrays"),
            Series(title: "Mobile Suit Gundam SEED VS Astray", logoName: "logo_seed_vs_astray"),
            Series(title: "Mobile Suit Gundam SEED Destiny Astray R", logoName: "logo_seed_destiny_astray_r"),
            Series(title: "Mobile Suit Gundam SEED Destiny Astray B", logoName: "logo_seed_destiny_astray_b"),
            Series(title: "Mobile Suit Gundam 00", logoName: "logo_00"),
            Series(title: "Mobile Suit Gundam 00P", logoName: "logo_00_p"),
            Series(title: "Mobile Suit Gundam 00F", logoName: "logo_00_f"),
            Series(title: "Mobile Suit Gundam 00I", logoName: "logo_00_i"),
            Series(title: "Mobile Suit Gundam 00V", logoName: "logo_00_v"),
            Series(title: "Mobile Suit Gundam 00V Senki", logoName: "logo_00_vw"),
            Series(title: "Mobile Suit Gundam 00 the Movie: A Wakening of the Trailblazer", logoName: "logo_00_gekijouban"),
            Series(title: "Mobile Suit Gundam Iron-Blooded Orphans", logoName: "logo_orphans"),
            Series(title: "Mobile Suit Gundam Iron-Blooded Orphans Gekko", logoName: "logo_orphans_msv"),
            Series(title: "SD Gundam GX", logoName: "logo_sd_gx"),
            Series(title: "G Generation Series", logoName: "logo_gg")
        ]
    }
}

//
//  WeaponList.swift
//  Windrise-Swift
//
//  Created by user on 17/05/22.
//

import SwiftUI

struct WeaponList: View {
    @State private var weapons: [String] = []
    
    var body: some View {
        NavigationView {
            List(weapons, id: \.self) { weapon in
                Text(weapon)
//                NavigationLink {
//                    CharacterDetail(character: Character(name: weapon))
//                } label: {
//                    Text(character)
//                }
//                .tag(character)
            }
            .onAppear {
                GenshinApi().getWeapons(completion: { weapons in
                    self.weapons = weapons
                })
            }
            .navigationTitle("Weapon List")
        }
    }
}

struct WeaponLIst_Previews: PreviewProvider {
    static var previews: some View {
        WeaponList()
    }
}

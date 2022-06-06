//
//  CharacterFilter.swift
//  Windrise-Swift
//
//  Created by user on 06/06/22.
//

import SwiftUI

struct CharacterFilter: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var showingFilter: Bool
    @Binding var selectedElement: CharacterList.Elements
    @Binding var selectedWeaponType: CharacterList.WeaponTypes
    
    var body: some View {
        NavigationView {
            Form {
                Picker("Elements", selection: $selectedElement) {
                    ForEach(CharacterList.Elements.allCases) { element in
                        Text(element.rawValue.capitalized)
                    }
                }
                .pickerStyle(.inline)
                
                Picker("Weapon Types", selection: $selectedWeaponType) {
                    ForEach(CharacterList.WeaponTypes.allCases) { weaponType in
                        Text(weaponType.rawValue.capitalized)
                    }
                }
                .pickerStyle(.inline)
            }
            .navigationTitle("Filter")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        selectedElement = .all
                        selectedWeaponType = .all
                    } label: {
                        Text("Reset")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        presentationMode.wrappedValue.dismiss()
                    } label: {
                        Text("Done")
                    }
                }
            }
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        }
    }
}

struct CharacterFilter_Previews: PreviewProvider {
    static var previews: some View {
        CharacterFilter(showingFilter: .constant(true), selectedElement: .constant(.all), selectedWeaponType: .constant(.all))
    }
}

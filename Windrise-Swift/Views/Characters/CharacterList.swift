//
//  CharacterList.swift
//  Windrise-Swift
//
//  Created by user on 15/05/22.
//

import SwiftUI

struct CharacterList: View {
    @EnvironmentObject private var mainViewModel: MainViewModel
    @State private var searchText: String = ""
    @State private var showingFilter: Bool = false
    @State private var selectedElement: Elements = .all
    @State private var selectedWeaponType: WeaponTypes = .all
    
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    private var characterDictionary: [String: Character] {
        Dictionary(uniqueKeysWithValues: zip(mainViewModel.characterIds, mainViewModel.characters))
    }
    
    private var filteredCharacters: [String: Character] {
        characterDictionary.filter({
            (selectedElement == .all || $0.value.visionKey.lowercased() == selectedElement.rawValue)
            && (selectedWeaponType == .all || $0.value.weaponType.lowercased() == selectedWeaponType.rawValue)
            && (searchText.isEmpty || $0.value.name.contains(searchText))
        })
    }
    
    
    enum Elements: String, CaseIterable, Identifiable {
        case all
        case anemo
        case cryo
        case dendro
        case electro
        case geo
        case hydro
        case pyro
        
        var id: Self { self }
    }
    
    enum WeaponTypes: String, CaseIterable, Identifiable {
        case all
        case bow
        case catalyst
        case claymore
        case polearm
        case sword
        
        var id: Self { self }
    }
    
    var body: some View {
        NavigationView {
            ScrollView (showsIndicators: false) {
                if (mainViewModel.characters.isEmpty) {
                    ProgressView()
                } else {
                    LazyVGrid(columns: columns) {
                        ForEach(Array(filteredCharacters.keys).sorted(by: <), id: \.self) { id in
                            let character = filteredCharacters[id]!
                            
                            NavigationLink(destination: CharacterDetail(id: id, character: character)) {
                                CharacterItem(id: id, character: character)
                            }
                            .tag(id)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Characters")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search a character")
            .toolbar {
                Button {
                    showingFilter.toggle()
                } label: {
                    Label("Filter", systemImage: "line.3.horizontal.decrease.circle")
                }
            }
            .background(Colors.background)
        }
        .sheet(isPresented: $showingFilter) {
            CharacterFilter(showingFilter: $showingFilter, selectedElement: $selectedElement, selectedWeaponType: $selectedWeaponType)
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(MainViewModel())
    }
}

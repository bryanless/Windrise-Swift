//
//  CharacterList.swift
//  Windrise-Swift
//
//  Created by user on 15/05/22.
//

import SwiftUI

struct CharacterList: View {
    @State private var names: [String] = []
    @State private var characters: [Character] = []
    
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView (showsIndicators: false) {
                LazyVGrid(columns: columns) {
                    ForEach(characters.indices, id: \.self) { index in
                        // FIXME: LazyVGrid causing MavigationLink animation lags
                        NavigationLink(destination: CharacterDetail(name: names[index], character: characters[index])) {
                            CharacterItem(id: names[index], name: characters[index].name, rarity: characters[index].rarity)
                        }
                        .tag(names[index])
                        .buttonStyle(PlainButtonStyle())
                    }
                }
            }
            .navigationTitle("Characters")
            .padding()
            .onAppear {
                GenshinApi().getCharactersName(completion: { names in
                    self.names = names
                })

                GenshinApi().getCharacters(completion: { characters in
                    self.characters = characters
                })
            }
            
//            List(characters.indices, id: \.self) { index in
//                NavigationLink {
//                    CharacterDetail(name: names[index], character: characters[index])
//                } label: {
//                    Text(characters[index].name)
//                }
//                .tag(names[index])
//            }
//            .navigationTitle("Characters")
//            .onAppear {
//                GenshinApi().getCharactersName(completion: { names in
//                    self.names = names
//                })
//
//                GenshinApi().getCharacters(completion: { characters in
//                    self.characters = characters
//                })
//            }
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CharacterList()
        }
    }
}

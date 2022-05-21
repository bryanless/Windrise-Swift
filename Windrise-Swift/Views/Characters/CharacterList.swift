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
    
    var body: some View {
        NavigationView {
            List(characters.indices, id: \.self) { index in
                NavigationLink {
                    CharacterDetail(name: names[index], character: characters[index])
                } label: {
                    Text(characters[index].name)
                }
                .tag(names[index])
            }
            .navigationTitle("Characters")
            .onAppear {
                GenshinApi().getCharactersName(completion: { names in
                    self.names = names
                })
                
                GenshinApi().getCharacters(completion: { characters in
                    self.characters = characters
                })
            }
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
    }
}

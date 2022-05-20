//
//  CharacterList.swift
//  Windrise-Swift
//
//  Created by user on 15/05/22.
//

import SwiftUI

struct CharacterList: View {
    @State private var characters: [String] = []
    
    var body: some View {
        NavigationView {
            List(characters, id: \.self) { character in
                NavigationLink {
                    CharacterDetail(character: Character(name: character))
                } label: {
                    Text(character)
                }
                .tag(character)
            }
            .onAppear {
                GenshinApi().getCharacters { characters in
                    self.characters = characters
                }
            }
            .navigationTitle("Character List")
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
    }
}

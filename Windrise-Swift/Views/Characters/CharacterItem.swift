//
//  CharacterItem.swift
//  Windrise-Swift
//
//  Created by user on 22/05/22.
//

import SwiftUI

struct CharacterItem: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    var id: String
    var character: Character
    
    var body: some View {
        VStack (spacing: 0) {
            ZStack {
                Image("background_item_\(character.rarity.description)_star")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                mainViewModel.icons[id]?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .aspectRatio(1, contentMode: .fit)
            .overlay (alignment: .topLeading) {
                CharacterElement(name: character.name)
                    .frame(width: 35)
                    .padding(4)
            }
            
            ZStack {
                Text(character.name)
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .allowsTightening(true)
            }
            .frame(maxWidth: .infinity, minHeight: 45, maxHeight: 45)
            .background(Colors.cardItemTextBackground)
        }
        .cornerRadius(8)
    }
}

struct CharacterItem_Previews: PreviewProvider {
    static var previews: some View {
        CharacterItem(id: "albedo", character: Character(name: "Albedo", rarity: 5))
            .environmentObject(MainViewModel())
    }
}

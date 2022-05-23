//
//  CharacterItem.swift
//  Windrise-Swift
//
//  Created by user on 22/05/22.
//

import SwiftUI

struct CharacterItem: View {
    @State var id: String
    @State var name: String
    @State var rarity: Int
    @State var icon: Image = Image("")
    
    var body: some View {
        VStack (spacing: 0) {
            ZStack {
                Image("background_item_\(rarity.description)_star")
                    .resizable()
                .aspectRatio(contentMode: .fit)
                
                icon
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .aspectRatio(1, contentMode: .fit)
            
            ZStack {
                Text(name)
                    .font(.callout)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
                    .allowsTightening(true)
            }
            .frame(maxWidth: .infinity, minHeight: 45, maxHeight: 45)
            .background(Colors.cardItemTextBackground)
        }
        .cornerRadius(8)
        .onAppear {
            GenshinApi().getCharacterIconBig(name: id) { icon in
                self.icon = icon
            }
        }
    }
}

struct CharacterItem_Previews: PreviewProvider {
    static var previews: some View {
        CharacterItem(id: "traveler-anemo", name: "Albedo", rarity: 1)
    }
}

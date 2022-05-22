//
//  CharacterItem.swift
//  Windrise-Swift
//
//  Created by user on 22/05/22.
//

import SwiftUI

struct CharacterItem: View {
    @State var name: String
    @State var rarity: Int
    
    var body: some View {
        VStack (spacing: 0) {
            Image("background_item_\(rarity.description)_star")
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            ZStack {
                Text(name)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .lineLimit(1)
                    .allowsTightening(true)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Colors.cardItemTextBackground)
            }
        }
        .cornerRadius(8)
    }
}

struct CharacterItem_Previews: PreviewProvider {
    static var previews: some View {
        CharacterItem(name: "Traveler", rarity: 1)
    }
}

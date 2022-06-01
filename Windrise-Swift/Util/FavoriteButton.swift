//
//  FavoriteButton.swift
//  Windrise-Swift
//
//  Created by user on 01/06/22.
//

import SwiftUI
import CoreData

struct FavoriteButton: View {
    @Environment(\.managedObjectContext) var moc
    @State var id: String
    @Binding var isSet: Bool
    @State var page: Page
    
    enum Page {
        case character
        case weapon
    }
    
    var body: some View {
        Button {
            isSet.toggle()
            
            switch (page) {
            case .character:
                let fetchFavoriteCharacters: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
                fetchFavoriteCharacters.predicate = NSPredicate(format: "id = %@", id)
                
                let results = try? moc.fetch(fetchFavoriteCharacters)
                
                if results?.count == 0 {
                    // New data
                    let favoriteCharacter = FavoriteCharacter(context: moc)
                    favoriteCharacter.id = id
                    favoriteCharacter.isFavorite = isSet
                } else {
                    // Data exists
                    let favoriteCharacter = results?.first
                    favoriteCharacter?.id = id
                    favoriteCharacter?.isFavorite = isSet
                }
            case .weapon:
                // TODO: Complete weapon
                let temp = "a"
            }
            
            try? moc.save()
        } label: {
            Label("Toggle Favorite", systemImage: isSet ? "heart.circle.fill" : "heart.circle")
                .font(.system(size: 44))
                .labelStyle(.iconOnly)
                .foregroundColor(isSet ? .red : .gray)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(id: "albedo", isSet: .constant(true), page: .character)
    }
}

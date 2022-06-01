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
            }
            
            try? moc.save()
        } label: {
            if isSet {
                FavoriteActive()
            } else {
                FavoriteInactive()
            }
//            Label("Toggle Favorite", systemImage: isSet ? "heart.circle.fill" : "heart.circle")
//                .font(.system(size: 44))
//                .labelStyle(.iconOnly)
//                .foregroundColor(isSet ? .red : .gray)
        }
    }
}

struct FavoriteInactive: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Colors.cardItemTextBackground)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 44)
            
            Image(systemName: "heart")
                .font(.system(size: 24))
                .foregroundColor(.gray)
                .offset(y: 1)
        }
    }
}

struct FavoriteActive: View {
    var body: some View {
        ZStack {
            Circle()
                .fill(Colors.favoriteBackgroundActive)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 44)
            
            Image(systemName: "heart.fill")
                .font(.system(size: 24))
                .foregroundColor(.white)
                .offset(y: 1)
        }
    }
}

struct FavoriteButton_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteButton(id: "albedo", isSet: .constant(true), page: .character)
    }
}

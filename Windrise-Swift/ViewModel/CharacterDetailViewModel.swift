//
//  CharacterDetailViewModel.swift
//  Windrise-Swift
//
//  Created by user on 31/05/22.
//

import Foundation
import SwiftUI
import CoreData

class CharacterDetailViewModel: ObservableObject {
    @Published var bannerImage: Image = Image("image_placeholder")
    @Published var isFavorite: Bool = false
    @Published var isOwned: Bool = false
    
    func fetch(id: String, moc: NSManagedObjectContext, completion: @escaping (Bool) -> ()) {
        GenshinApi().getCharacterGachaSplash(id: id) { image in
            self.bannerImage = image
            completion(false)
        }
        
        // MARK: Get Favorite Status
        let fetchFavoriteCharacters: NSFetchRequest<FavoriteCharacter> = FavoriteCharacter.fetchRequest()
        fetchFavoriteCharacters.predicate = NSPredicate(format: "id = %@", id)
        
        if let results = try? moc.fetch(fetchFavoriteCharacters) {
            if results.count != 0 {
                // Data exists
                if let favoriteCharacter = results.first {
                    self.isFavorite = favoriteCharacter.isFavorite
                }
            }
        }
        
        // MARK: Get Own Status
        let fetchOwnCharacters: NSFetchRequest<OwnCharacter> = OwnCharacter.fetchRequest()
        fetchOwnCharacters.predicate = NSPredicate(format: "id = %@", id)
        
        if let results = try? moc.fetch(fetchOwnCharacters) {
            if results.count != 0 {
                // Data exists
                if let ownCharacter = results.first {
                    self.isOwned = ownCharacter.isOwned
                }
            }
        }
    }
}

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
    @Published var talentIcons:[String: Image] = [:]
    @Published var constellationIcons:[Int: Image] = [:]
    
    private let talents:[String] = ["na", "skill", "burst", "passive-0", "passive-1", "passive-2", "passive-misc"]
    
    func fetch(id: String, moc: NSManagedObjectContext, completion: @escaping (Bool) -> ()) {
        // MARK: Get gacha splash
        GenshinApi().getCharacterGachaSplash(id: id) { image in
            self.bannerImage = image
            completion(false)
        }
        
        // MARK: Get talent icons
        for talent in talents {
            GenshinApi().getCharacterTalentIcon(id: id, talent: talent) { icon in
                self.talentIcons[talent] = icon
            }
        }
        
        // MARK: Get constellation icons
        for i in 0..<7 {
            GenshinApi().getCharacterConstellationIcon(id: id, constellation: i) { icon in
                self.constellationIcons[i] = icon
            }
        }
        
        // MARK: Get favorite status
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
        
        // MARK: Get own status
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

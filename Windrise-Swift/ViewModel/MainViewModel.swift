//
//  MainViewModel.swift
//  Windrise-Swift
//
//  Created by user on 31/05/22.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var characterIds: [String] = []
    @Published var characters: [Character] = []
    @Published var icons: [String : Image] = [:]
    @Published var elementIcons: [String : Image] = [:]
    
    @Published var weaponIds: [String] = []
    @Published var weapons: [Weapon] = []
    
    init() {
        fetch()
    }
    
    private func fetch() {
        // MARK: Character
        GenshinApi().getCharacterIds(completion: { ids in
            self.characterIds = ids
            
            for id in ids {
                GenshinApi().getCharacterIconBig(id: id) { icon in
                    self.icons[id] = icon
                }
            }
        })
        
        GenshinApi().getCharacters(completion: { characters in
            self.characters = characters
        })
        
        GenshinApi().getElementIds { elements in
            for element in elements {
                GenshinApi().getElementIcon(element: element) { image in
                    self.elementIcons[element] = image
                }
            }
        }
        
        // MARK: Weapon
        GenshinApi().getWeaponIds { ids in
            self.weaponIds = ids
        }
        
        GenshinApi().getWeapons { weapons in
            self.weapons = weapons
        }
    }
}

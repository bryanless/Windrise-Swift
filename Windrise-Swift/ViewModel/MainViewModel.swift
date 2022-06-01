//
//  MainViewModel.swift
//  Windrise-Swift
//
//  Created by user on 31/05/22.
//

import Foundation
import SwiftUI

class MainViewModel: ObservableObject {
    @Published var ids: [String] = []
    @Published var characters: [Character] = []
    @Published var icons: [String : Image] = [:]
    @Published var elementIcons: [String : Image] = [:]
    
    init() {
        fetch()
    }
    
    private func fetch() {
        GenshinApi().getCharactersName(completion: { names in
            self.ids = names
            
            for name in names {
                GenshinApi().getCharacterIconBig(id: name) { icon in
                    self.icons[name] = icon
                }
            }
        })
        
        GenshinApi().getCharacters(completion: { characters in
            self.characters = characters
        })
        
        GenshinApi().getElements { elements in
            for element in elements {
                GenshinApi().getElementIcon(element: element) { image in
                    self.elementIcons[element] = image
                }
            }
        }
    }
}

//
//  CharacterDetailViewModel.swift
//  Windrise-Swift
//
//  Created by user on 31/05/22.
//

import Foundation
import SwiftUI

class CharacterDetailViewModel: ObservableObject {
    @Published var bannerImage: Image = Image("image_placeholder")
    
    func fetch(id: String, completion: @escaping (Bool) -> ()) {
        GenshinApi().getCharacterGachaSplash(id: id) { image in
            self.bannerImage = image
            completion(false)
        }
    }
}

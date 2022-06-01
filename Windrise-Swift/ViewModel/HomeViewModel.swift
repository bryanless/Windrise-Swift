//
//  HomeViewModel.swift
//  Windrise-Swift
//
//  Created by user on 01/06/22.
//

import Foundation
import SwiftUI

class HomeViewModel: ObservableObject {
    private var featuredImagePath: [String] = ["yelan_banner_2_7", "xiao_banner_2_7", "weapon_banner_2_7"]
    var featuredImages: [Image] = []
    
    init() {
        featuredImages = featuredImagePath.map { path in
            Image(path)
        }
    }
}

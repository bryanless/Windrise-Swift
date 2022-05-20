//
//  Element.swift
//  Windrise-Swift
//
//  Created by user on 19/05/22.
//

import Foundation

// MARK: - Element
struct Element: Codable {
    var name: String = ""
    var key: String = ""
    var reactions: [Reaction] = []
}

// MARK: - Reaction
struct Reaction: Codable {
    var name: String = ""
    var elements: [String] = []
    var description: String = ""
    
    enum CodingKeys: String, CodingKey {
        case name, elements, description
    }
}

//
//  Weapon.swift
//  Windrise-Swift
//
//  Created by user on 17/05/22.
//

import Foundation

// MARK: - Weapon
struct Weapon: Codable, Identifiable {
    var id = UUID()
    var name: String = ""
    var type: String = ""
    var rarity: Int = 0
    var baseAttack: Int = 0
    var subStat: String = ""
    var passiveName: String = ""
    var assiveDesc: String = ""
    var location: String = ""
}

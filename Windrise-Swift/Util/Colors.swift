//
//  Colors.swift
//  Windrise-Swift
//
//  Created by user on 19/05/22.
//

import Foundation
import QuartzCore
import SwiftUI

private let purpleLight = Color(red: 74 / 255, green: 57 / 255, blue: 124 / 255)

struct Colors {
    static let cardSurface = purpleLight
    
    static let blackShade = LinearGradient(
        gradient: Gradient(colors: [Color(uiColor: UIColor(white: 0, alpha: 0.3)),
                                    Color(uiColor: UIColor(white: 0, alpha: 0.6))]),
        startPoint: .top,
        endPoint: .bottom)
}

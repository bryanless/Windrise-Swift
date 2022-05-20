//
//  Colors.swift
//  Windrise-Swift
//
//  Created by user on 19/05/22.
//

import Foundation
import QuartzCore
import SwiftUI

private let purpleSoft = Formatter.rgbToColor(red: 74, green: 57, blue: 124)
private let purpleDark = Formatter.rgbToColor(red: 0, green: 7, blue: 72)
private let purpleLight = Formatter.rgbToColor(red: 91, green: 0, blue: 106)

struct Colors {
    static let cardSurface = purpleSoft
    
    static let background = LinearGradient(
        gradient: Gradient(colors: [purpleDark, purpleLight]),
        startPoint: .top,
        endPoint: .bottom)
    
    static let blackShade = LinearGradient(
        gradient: Gradient(colors: [Color(uiColor: UIColor(white: 0, alpha: 0.4)),
                                    Color(uiColor: UIColor(white: 0, alpha: 0.6))]),
        startPoint: .top,
        endPoint: .bottom)
}

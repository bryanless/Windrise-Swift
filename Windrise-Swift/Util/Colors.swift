//
//  Colors.swift
//  Windrise-Swift
//
//  Created by user on 19/05/22.
//

import Foundation
import QuartzCore
import SwiftUI

private let purpleSoftest = Formatter.rgbToColor(red: 184, green: 170, blue: 206)
private let purpleSofter = Formatter.rgbToColor(red: 105, green: 84, blue: 164)
private let purpleSoft = Formatter.rgbToColor(red: 74, green: 57, blue: 124)
private let purpleDark = Formatter.rgbToColor(red: 0, green: 7, blue: 72)
private let purpleLight = Formatter.rgbToColor(red: 91, green: 0, blue: 106)
private let creamLight = Formatter.rgbToColor(red: 233, green: 229, blue: 220)
private let orange = Formatter.rgbToColor(red: 255, green: 138, blue: 1)
private let green = Formatter.rgbToColor(red: 0, green: 255, blue: 148)
private let blueLight = Formatter.rgbToColor(red: 60, green: 161, blue: 255)

struct Colors {
    static let pickerBackground = purpleSoftest
    static let selectedPicker = purpleSofter
    
    static let cardSurface = purpleSoft
    static let cardItemTextBackground = creamLight
    
    static let favoriteBackgroundActive = LinearGradient(
        gradient: Gradient(colors: [orange, .red]),
        startPoint: .top,
        endPoint: .bottom)
    
    static let ownBackgroundActive = LinearGradient(
        gradient: Gradient(colors: [green, blueLight]),
        startPoint: .top,
        endPoint: .bottom)
    
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

//
//  AscensionButton.swift
//  Windrise-Swift
//
//  Created by user on 24/05/22.
//

import SwiftUI

struct AscensionButton: View {
    var constellation: Int
    @Binding var selectedConstellation: Int
    @Binding var constellationSelection: [Bool]
    
    var body: some View {
        Button {
            selectedConstellation = constellation
            
            for i in 0..<constellationSelection.count {
                if (i < constellation + 1) {
                    constellationSelection[i] = true
                } else {
                    constellationSelection[i] = false
                }
            }
            
        } label: {
            Shapes.Star(corners: 4, smoothness: 0.45)
                .fill(constellationSelection[constellation] ? .yellow : .gray)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 44, height: 44)
        }
    }
}

struct AscensionButton_Previews: PreviewProvider {
    static var previews: some View {
        AscensionButton(constellation: 1, selectedConstellation: .constant(0), constellationSelection: .constant([true, false, false, false, false, false]))
    }
}

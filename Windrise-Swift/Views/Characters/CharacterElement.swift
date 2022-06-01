//
//  CharacterElement.swift
//  Windrise-Swift
//
//  Created by user on 24/05/22.
//

import SwiftUI

struct CharacterElement: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    var name: String
    
    var body: some View {
        mainViewModel.elementIcons[name]?
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(4)
    }
}

struct CharacterElement_Previews: PreviewProvider {
    static var previews: some View {
        CharacterElement(name: "albedo")
            .environmentObject(MainViewModel())
    }
}

//
//  CharacterElement.swift
//  Windrise-Swift
//
//  Created by user on 24/05/22.
//

import SwiftUI

struct CharacterElement: View {
    @State var element: String
    // TODO: Change default image
    @State private var elementImage: Image = Image("")
    var body: some View {
        elementImage
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(4)
//            .background(RoundedRectangle(cornerRadius: 6)
//                .fill(Color.black.opacity(0.4)))
            .onAppear {
                GenshinApi().getElementIcon(element: element) { icon in
                    self.elementImage = icon
                }
            }
    }
}

struct CharacterElement_Previews: PreviewProvider {
    static var previews: some View {
        CharacterElement(element: "geo")
    }
}

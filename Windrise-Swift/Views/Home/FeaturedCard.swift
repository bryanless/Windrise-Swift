//
//  FeaturedCard.swift
//  Windrise-Swift
//
//  Created by user on 01/06/22.
//

import SwiftUI

struct FeaturedCard: View {
    var image: Image
    
    var body: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct FeaturedCard_Previews: PreviewProvider {
    static var previews: some View {
        FeaturedCard(image: Image("yelan_banner_2_7"))
    }
}

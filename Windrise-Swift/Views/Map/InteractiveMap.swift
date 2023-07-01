//
//  InteractiveMap.swift
//  Windrise-Swift
//
//  Created by user on 06/06/22.
//

import SwiftUI

struct InteractiveMap: View {
    @State private var isLoading: Bool = true
    
    var body: some View {
        VStack {
            WebView(url: URL(string: "https://act.hoyolab.com/ys/app/interactive-map/index.html")!, isLoading: $isLoading)
                .overlay {
                    if isLoading {
                        ProgressView()
                    }
                }
        }
    }
}

struct InteractiveMap_Previews: PreviewProvider {
    static var previews: some View {
        InteractiveMap()
    }
}

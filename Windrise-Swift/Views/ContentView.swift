//
//  ContentView.swift
//  Windrise-Swift
//
//  Created by user on 20/05/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .home
    
    enum Tab {
        case home
    }
    
    var body: some View {
        TabView(selection: $selection) {
            CharacterList()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

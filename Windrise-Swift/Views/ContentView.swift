//
//  ContentView.swift
//  Windrise-Swift
//
//  Created by user on 20/05/22.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .characters
    
    enum Tab {
        case home
        case characters
        case weapons
        case profile
    }
    
    var body: some View {
        TabView(selection: $selection) {
            Home()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .tag(Tab.home)
            
            CharacterList()
                .tabItem {
                    Label("Characters", systemImage: "person.2")
                }
                .tag(Tab.characters)
            
//            WeaponList()
//                .tabItem {
//                    Label("Weapons", systemImage: "shield")
//                }
//                .tag(Tab.weapons)
            
            Profile()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }
                .tag(Tab.profile)
        }
        .onAppear {
            UITabBar.appearance().backgroundColor = UIColor.white
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(MainViewModel())
    }
}

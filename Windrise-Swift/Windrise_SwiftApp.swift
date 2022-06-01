//
//  Windrise_SwiftApp.swift
//  Windrise-Swift
//
//  Created by user on 20/05/22.
//

import SwiftUI

@main
struct Windrise_SwiftApp: App {
    @StateObject private var dataController = DataController()
    @StateObject private var mainViewModel = MainViewModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
                .environmentObject(mainViewModel)
        }
    }
}

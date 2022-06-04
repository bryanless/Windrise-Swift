//
//  CharacterList.swift
//  Windrise-Swift
//
//  Created by user on 15/05/22.
//

import SwiftUI

struct CharacterList: View {
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView (showsIndicators: false) {
                if (mainViewModel.characters.isEmpty) {
                    ProgressView()
                } else {
                    LazyVGrid(columns: columns) {
                        ForEach(mainViewModel.characters.indices, id: \.self) { index in
                            let id = mainViewModel.characterIds[index]
                            let character = mainViewModel.characters[index]
                            
                            NavigationLink(destination: CharacterDetail(id: id, character: character)) {
                                CharacterItem(id: id, character: character)
                            }
                            .tag(id)
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Characters")
            .background(Colors.background)
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        CharacterList()
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(MainViewModel())
    }
}

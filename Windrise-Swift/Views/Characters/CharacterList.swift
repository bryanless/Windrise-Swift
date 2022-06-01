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
                            NavigationLink(destination: CharacterDetail(id: mainViewModel.ids[index], character: mainViewModel.characters[index])) {
                                CharacterItem(id: mainViewModel.ids[index], character: mainViewModel.characters[index])
                            }
                            .tag(mainViewModel.ids[index])
                            .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Characters")
        }
    }
}

struct CharacterList_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CharacterList()
                .environmentObject(MainViewModel())
        }
    }
}

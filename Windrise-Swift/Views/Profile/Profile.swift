//
//  Profile.swift
//  Windrise-Swift
//
//  Created by user on 01/06/22.
//

import SwiftUI
import CoreData

struct Profile: View {
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)],
        predicate: NSPredicate(format: "isFavorite = true")) private var favoriteCharacters: FetchedResults<FavoriteCharacter>
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)],
        predicate: NSPredicate(format: "isOwned = true")) private var ownCharacters: FetchedResults<OwnCharacter>
    @EnvironmentObject private var mainViewModel: MainViewModel
    
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView (showsIndicators: false) {
                VStack (spacing: 20) {
                    // MARK: Owned Characters
                    VStack (alignment: .leading, spacing: 10) {
                        Text("My Characters")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        if (mainViewModel.characters.isEmpty) {
                            ProgressView()
                        } else {
                            LazyVGrid(columns: columns) {
                                ForEach(ownCharacters, id: \.self) { character in
                                    if let index = mainViewModel.ids.firstIndex(of: character.id ?? "0") {
                                        NavigationLink(destination: CharacterDetail(id: mainViewModel.ids[index], character: mainViewModel.characters[index])) {
                                            CharacterItem(id: mainViewModel.ids[index], character: mainViewModel.characters[index])
                                        }
                                        .tag(mainViewModel.ids[index])
                                        .buttonStyle(PlainButtonStyle())
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Profile")
            .background(Colors.background)
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
}

struct Profile_Previews: PreviewProvider {
    static var previews: some View {
        Profile()
            .environmentObject(MainViewModel())
    }
}

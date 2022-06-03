//
//  Home.swift
//  Windrise-Swift
//
//  Created by user on 01/06/22.
//

import SwiftUI

struct Home: View {
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)],
        predicate: NSPredicate(format: "isFavorite = true")) private var favoriteCharacters: FetchedResults<FavoriteCharacter>
    @EnvironmentObject private var mainViewModel: MainViewModel
    @StateObject private var viewModel: HomeViewModel = HomeViewModel()
    
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView (showsIndicators: false) {
                VStack (spacing: 20) {
                    // MARK: Current Banners
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Current Banners")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        PageView(pages: viewModel.featuredImages.map { FeaturedCard(image: $0) })
                            .aspectRatio(2.03/1, contentMode: .fill)
                        .cornerRadius(8)
                    }
                    
                    // MARK: Favorite Characters
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Favorite Characters")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                        
                        if (mainViewModel.characters.isEmpty) {
                            ProgressView()
                        } else {
                            if (favoriteCharacters.isEmpty) {
                                HStack {
                                    Spacer()
                                    
                                    Text("Add a character to favorite to be shown here")
                                        .font(.callout)
                                        .foregroundColor(.white)
                                        .padding()
                                    
                                    Spacer()
                                }
                            } else {
                                LazyVGrid(columns: columns) {
                                    ForEach(favoriteCharacters, id: \.self) { character in
                                        if let index = mainViewModel.characterIds.firstIndex(of: character.id ?? "0") {
                                            NavigationLink(destination: CharacterDetail(id: mainViewModel.characterIds[index], character: mainViewModel.characters[index])) {
                                                CharacterItem(id: mainViewModel.characterIds[index], character: mainViewModel.characters[index])
                                            }
                                            .tag(mainViewModel.characterIds[index])
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Home")
            .background(Colors.background)
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
            .environmentObject(MainViewModel())
    }
}

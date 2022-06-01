//
//  Home.swift
//  Windrise-Swift
//
//  Created by user on 01/06/22.
//

import SwiftUI

struct Home: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(
        sortDescriptors: [SortDescriptor(\.id)],
        predicate: NSPredicate(format: "isFavorite = true")) private var favoriteCharacters: FetchedResults<FavoriteCharacter>
    @EnvironmentObject private var mainViewModel: MainViewModel
    @StateObject private var homeViewModel: HomeViewModel = HomeViewModel()
    
    private var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        NavigationView {
            ScrollView (showsIndicators: false) {
                VStack (spacing: 20) {
                    // MARK: Current Banners
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Current Banners")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        PageView(pages: homeViewModel.featuredImages.map { FeaturedCard(image: $0) })
                            .aspectRatio(2.03/1, contentMode: .fill)
                        .cornerRadius(8)
                    }
                    
                    // MARK: Favorite Characters
                    VStack (alignment: .leading, spacing: 10) {
                        Text("Favorite Characters")
                            .font(.title2)
                            .foregroundColor(.white)
                        
                        if (mainViewModel.characters.isEmpty) {
                            ProgressView()
                        } else {
                            LazyVGrid(columns: columns) {
                                ForEach(favoriteCharacters, id: \.self) { character in
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

//
//  CharacterDetail.swift
//  Windrise-Swift
//
//  Created by user on 14/05/22.
//

import SwiftUI
import CoreData

struct CharacterDetail: View {
    @Environment(\.managedObjectContext) var moc
    @EnvironmentObject var mainViewModel: MainViewModel
    @StateObject var viewModel: CharacterDetailViewModel = CharacterDetailViewModel()
    var id: String
    var character: Character
    @State private var isBannerLoading: Bool = true
    @State private var selectedAttack: Attack = .basic
    @State private var selectedConstellation: Int = 0
    @State private var constellationSelection: [Bool] = [true, false, false, false, false, false]
    
    enum Attack: String, CaseIterable, Identifiable {
        case basic, skill, burst
        
        var id: Self { self }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ZStack {
                    if isBannerLoading {
                        ProgressView()
                            .tint(Color.white)
                            .frame(height: 300)
                    } else {
                        viewModel.bannerImage
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                    }
                    
                    ZStack (alignment: .topTrailing) {
                        Color.clear
                        
                        HStack {
                            FavoriteButton(id: id, isSet: $viewModel.isFavorite, page: .character)
                            
                            OwnButton(id: id, isSet: $viewModel.isOwned, page: .character)
                        }
                        .padding()
                    }
                }
                
                VStack (spacing: 15) {
                    // MARK: - Profile
                    Group {
                        VStack (spacing: 8) {
                            Text(character.name)
                                .font(.title)
                            
                            HStack (spacing: 0) {
                                ForEach(0..<character.rarity, id: \.self) { _ in
                                    Image(systemName: "star.fill")
                                        .foregroundColor(Color.yellow)
                                }
                            }
                            
                            HStack (alignment: .center, spacing: 25) {
                                VStack (alignment: .leading, spacing: 10) {
                                    Text("Vision")
                                    
                                    Text("Weapon")
                                    
                                    if (character.birthday != nil) {
                                        Text("Birthday")
                                    }
                                }
                                
                                VStack (alignment: .leading, spacing: 10) {
                                    HStack {
                                        mainViewModel.elementIcons[character.visionKey.lowercased()]?
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                        
                                        Text(character.vision)
                                            .lineLimit(1)
                                            .offset(x: -5)
                                    }
                                    .frame(maxHeight: 21)
                                    
                                    Text(character.weapon)
                                    
                                    if (character.birthday != nil) {
                                        Text(Formatter.dateToBirthday(character.birthday!))
                                    }
                                }
                                .font(.headline)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .padding()
                    }
                    .background(Shapes.roundedCard
                        .fill(Colors.blackShade))
                    .offset(y: -100)
                    .padding(.bottom, -100)
                    
                    // MARK: - Other
                    Group {
                        // MARK: - Description
                        VStack(spacing: 20) {
                            Text("Description")
                                .font(.title2)
                            
                            Text(character.description)
                                .multilineTextAlignment(.leading)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        // MARK: - Attack
                        VStack(spacing: 20) {
                            Text("Attack")
                                .font(.title2)
                            
                            Picker("Attack", selection: $selectedAttack) {
                                ForEach(Attack.allCases) { attack in
                                    Text(attack.rawValue.capitalized)
                                }
                            }
                            .pickerStyle(.segmented)
                            
                            if(!character.skillTalents.isEmpty) {
                                switch selectedAttack {
                                case .basic:
                                    let basic = character.skillTalents[0]
                                    let descriptions = Formatter.descriptionToArray(basic.description)
                                    
                                    HStack {
                                        viewModel.talentIcons["na"]?
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 40)
                                        
                                        Text(basic.name)
                                            .font(.title3)
                                    }
                                    
                                    VStack (alignment: .leading, spacing: 5) {
                                        ForEach(descriptions.indices, id: \.self) { index in
                                            if (!descriptions[index].isEmpty) {
                                                if (index % 2 == 0) {
                                                    Text(descriptions[index])
                                                        .font(.headline)
                                                } else {
                                                    Text(descriptions[index])
                                                        .font(.body)
                                                        .padding(.bottom, 15)
                                                }
                                            }
                                        }
                                    }
                                    
                                case .skill:
                                    let skill = character.skillTalents[1]
                                    
                                    HStack {
                                        viewModel.talentIcons["skill"]?
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 40)
                                        
                                        Text(skill.name)
                                            .font(.title3)
                                    }
                                    
                                    Text(skill.description)
                                        .multilineTextAlignment(.leading)
                                case .burst:
                                    let burst = character.skillTalents[2]
                                    
                                    HStack {
                                        viewModel.talentIcons["burst"]?
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 40)
                                        
                                        Text(burst.name)
                                            .font(.title3)
                                    }
                                    
                                    Text(burst.description)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                        .padding()
                        
                        // MARK: - Passive
                        VStack (spacing: 20) {
                            Text("Passive")
                                .font(.title2)
                            
                            ForEach (character.passiveTalents.indices, id: \.self) { index in
                                let passive = character.passiveTalents[index]
                                
                                VStack (alignment: .leading, spacing: 10) {
                                    HStack {
                                        viewModel.talentIcons["passive-\(index > 1 ? 0 : index + 1)"]?
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 40)
                                        
                                        Text(passive.name)
                                            .font(.headline)
                                    }
                                    
                                    Text(passive.description)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                            
                            // MARK: Sprint passive
                            if (character.skillTalents.count == 4) {
                                VStack (alignment: .leading, spacing: 10) {
                                    let misc = character.skillTalents[3]
                                    var descriptionArray = Formatter.descriptionToArray(misc.description)
                                    let subheadline = descriptionArray[0]
                                    let descriptionString = Formatter.arrayToDescriptionWithoutFirst(&descriptionArray)
                                    
                                    HStack {
                                        viewModel.talentIcons["passive-misc"]?
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 40)
                                        
                                        VStack (alignment: .leading) {
                                            Text(misc.name)
                                                .font(.headline)
                                            
                                            Text(subheadline)
                                                .font(.subheadline)
                                        }
                                    }
                                    
                                    Text(descriptionString)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        
                        // MARK: - Constellation
                        VStack (spacing: 20) {
                            Text("Constellation")
                                .font(.title2)
                            
                            HStack {
                                ForEach(0..<character.constellations.count, id:\.self) { i in
                                    AscensionButton(constellation: i, selectedConstellation: $selectedConstellation, constellationSelection: $constellationSelection)
                                }
                            }
                            
                            if(!character.constellations.isEmpty) {
                                let constellation = character.constellations[selectedConstellation]
                                
                                VStack (alignment: .leading, spacing: 10) {
                                    HStack {
                                        viewModel.constellationIcons[selectedConstellation + 1]?
                                            .resizable()
                                            .aspectRatio(1, contentMode: .fit)
                                            .frame(width: 40)
                                        
                                        Text(constellation.name)
                                            .font(.headline)
                                    }
                                    
                                    Text(constellation.description)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                    }
                    .background(Shapes.roundedCard
                        .fill(Colors.cardSurface))
                }
                .padding()
                .foregroundColor(.white)
            }
            .background(Colors.background)
        }
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(Colors.selectedPicker)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
            UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
            UISegmentedControl.appearance().backgroundColor = UIColor(Colors.pickerBackground)
            
            viewModel.fetch(id: id, moc: moc) { isBannerLoading in
                self.isBannerLoading = isBannerLoading
            }
        }
    }
    
    struct CharacterDetail_Previews: PreviewProvider {
        static var mainViewModel = MainViewModel()
        
        static var previews: some View {
            CharacterDetail(id: mainViewModel.characterIds.first ?? "", character: mainViewModel.characters.first ?? Character())
                .environment(\.managedObjectContext, DataController().container.viewContext)
                .environmentObject(mainViewModel)
        }
    }
}

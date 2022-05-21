//
//  CharacterDetail.swift
//  Windrise-Swift
//
//  Created by user on 14/05/22.
//

import SwiftUI

struct CharacterDetail: View {
    @State var name: String
    @State var character: Character
    // TODO: Change default image
    @State private var element: Image = Image("turtlerock")
    @State private var bannerImage: Image = Image("turtlerock_feature")
    
    enum Attack: String, CaseIterable, Identifiable {
        case basic, skill, burst
        
        var id: Self { self }
    }
    
    @State private var selectedAttack: Attack = .basic
    
    var body: some View {
        ScrollView {
            VStack {
                bannerImage
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                VStack (spacing: 15) {
                    // MARK: Profile
                    Group {
                        VStack {
                            Text(character.name)
                                .font(.title)
                            
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
                                        element
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
                                // TODO: Reconsider the font
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
                    
                    // MARK: Other
                    Group {
                        // MARK: Description
                        VStack(spacing: 20) {
                            Text("Description")
                                .font(.title2)
                            
                            Text(character.description)
                                .multilineTextAlignment(.leading)
                        }
                        .frame(maxWidth: .infinity)
                        .padding()
                        
                        // MARK: Attack
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
                                    
                                    Text(basic.name)
                                        .font(.title3)
                                    
                                    VStack (alignment: .leading, spacing: 5) {
                                        ForEach(descriptions.indices, id: \.self) { index in
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
                                    
                                case .skill:
                                    let skill = character.skillTalents[1]
                                    
                                    Text(skill.name)
                                        .font(.title3)
                                    
                                    Text(skill.description)
                                        .multilineTextAlignment(.leading)
                                case .burst:
                                    let burst = character.skillTalents[2]
                                    
                                    Text(burst.name)
                                        .font(.title3)
                                    
                                    Text(burst.description)
                                        .multilineTextAlignment(.leading)
                                }
                            }
                        }
                        .padding()
                        
                        // MARK: Passive
                        VStack (spacing: 20) {
                            Text("Passive")
                                .font(.title2)
                            
                            ForEach (character.passiveTalents) { passive in
                                VStack (alignment: .leading, spacing: 5) {
                                    Text(passive.name)
                                        .font(.headline)
                                    
                                    Text(passive.description)
                                }
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        }
                        .padding()
                        
                        // MARK: Constellation
                        VStack (spacing: 20) {
                            Text("Constellation")
                                .font(.title2)
                            
                            ForEach (character.constellations) { constellation in
                                //                            Text(constellation.level?.description ?? "0")
                                
                                VStack (alignment: .leading, spacing: 5) {
                                    Text(constellation.name)
                                        .font(.headline)
                                    
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
        }
        .background(Colors.background)
        // FIXME: Change navigation title color to white
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {            
            GenshinApi().getCharacterGachaSplash(name: name) { image in
                self.bannerImage = image
            }
            
            GenshinApi().getElementIcon(element: character.vision) { image in
                self.element = image
            }
            
            // TODO: Remove this from release version
//            GenshinApi().getCharacter(name: name) { character in
//                self.character = character
//            }
        }
    }
    
    struct CharacterDetail_Previews: PreviewProvider {
        static var previews: some View {
            CharacterDetail(name: "albedo", character: Character())
        }
    }
}

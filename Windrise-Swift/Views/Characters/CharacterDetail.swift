//
//  CharacterDetail.swift
//  Windrise-Swift
//
//  Created by user on 14/05/22.
//

import SwiftUI

struct CharacterDetail: View {
    @State var character: Character
    // TODO: Change default image
    @State private var element: Image = Image("turtlerock")
    @State private var gachaSplash: Image = Image("turtlerock-featured")
    
    enum Attack: String, CaseIterable, Identifiable {
        case basic, skill, burst
        var id: Self { self }
    }
    
    @State private var selectedAttack: Attack = .basic
    
    var body: some View {
        ScrollView {
            VStack {
                gachaSplash
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                // MARK: Profile
                Group {
                    VStack {
                        Text(character.name)
                            .font(.title)
                        
                        HStack (alignment: .center, spacing: 25) {
                            VStack (alignment: .leading, spacing: 10) {
                                Text("Element")
                                
                                Text("Weapon")
                                
                                Text("Birthday")
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
                                
                                Text(DateFormat.dateToBirthday(character.birthday))
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
                    // FIXME: Text width doesn't match frame width
                    VStack(spacing: 20) {
                        Text("Description")
                            .font(.title2)
                        
                        Text(character.description)
                            .multilineTextAlignment(.leading)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    
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
                        
                        ForEach (character.skillTalents) { skill in
                            VStack(spacing: 10) {
                                Text(skill.name)
                                    .font(.headline)
                                
                                Text(skill.description)
                            }
                        }
                    }
                    .padding()
                    
                    VStack (alignment: .leading) {
                        ForEach (character.constellations) { constellation in
                            Text(constellation.level?.description ?? "0")

                            Text(constellation.name)
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
        .navigationTitle(character.name)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            GenshinApi().getCharacter(name: character.name) { character in
                self.character = character
                
                
                GenshinApi().getElementIcon(element: character.vision) { image in
                    self.element = image
                }
            }
            
            GenshinApi().getCharacterGachaSplash(name: character.name) { image in
                self.gachaSplash = image
            }
        }
    }
    
    struct CharacterDetail_Previews: PreviewProvider {
        static var previews: some View {
            CharacterDetail(character: Character(name: "albedo"))
        }
    }
}

//
//  OwnButton.swift
//  Windrise-Swift
//
//  Created by user on 01/06/22.
//

import SwiftUI
import CoreData

struct OwnButton: View {
    @Environment(\.managedObjectContext) var moc
    @State var id: String
    @Binding var isSet: Bool
    @State var page: Page
    
    enum Page {
        case character
    }
    
    var body: some View {
        Button {
            isSet.toggle()
            
            switch (page) {
            case .character:
                let fetchOwnCharacters: NSFetchRequest<OwnCharacter> = OwnCharacter.fetchRequest()
                fetchOwnCharacters.predicate = NSPredicate(format: "id = %@", id)
                
                let results = try? moc.fetch(fetchOwnCharacters)
                
                if results?.count == 0 {
                    // New data
                    let fetchOwnCharacters = OwnCharacter(context: moc)
                    fetchOwnCharacters.id = id
                    fetchOwnCharacters.isOwned = isSet
                } else {
                    // Data exists
                    let fetchOwnCharacters = results?.first
                    fetchOwnCharacters?.id = id
                    fetchOwnCharacters?.isOwned = isSet
                }
            }
            
            try? moc.save()
        } label: {
            if isSet {
                OwnActive()
            } else {
                OwnInactive()
            }
//            Label("Toggle Own", systemImage: isSet ? "checkmark.circle.fill" : "checkmark.circle")
//                .font(.system(size: 44))
//                .labelStyle(.iconOnly)
//                .foregroundColor(isSet ? .green : .gray)
        }
    }
}

struct OwnInactive: View {
    var body: some View {
        ZStack (alignment: .center) {
            Circle()
                .fill(Colors.cardItemTextBackground)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 44)
            
            Image(systemName: "checkmark")
                .font(.system(size: 24))
                .foregroundColor(.gray)
        }
    }
}

struct OwnActive: View {
    var body: some View {
        ZStack (alignment: .center) {
            Circle()
                .fill(Colors.ownBackgroundActive)
                .aspectRatio(1, contentMode: .fit)
                .frame(width: 44)
            
            Image(systemName: "checkmark")
                .font(.system(size: 24))
                .foregroundColor(.white)
        }
    }
}

struct OwnButton_Previews: PreviewProvider {
    static var previews: some View {
        OwnButton(id: "albedo", isSet: .constant(true), page: .character)
    }
}

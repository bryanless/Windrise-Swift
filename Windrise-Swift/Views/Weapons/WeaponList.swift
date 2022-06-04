//
//  WeaponList.swift
//  Windrise-Swift
//
//  Created by user on 17/05/22.
//

import SwiftUI

struct WeaponList: View {
    @EnvironmentObject var mainViewModel: MainViewModel
    
    var body: some View {
        NavigationView {
            List(mainViewModel.weaponIds.indices, id: \.self) { index in
                let id = mainViewModel.weaponIds[index]

                NavigationLink {
                    WeaponDetail()
                } label: {
                    Text(id)
                }
                .tag(id)
            }
            .navigationTitle("Weapons")
            .background(Colors.background)
        }
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]
        }
    }
}

struct WeaponLIst_Previews: PreviewProvider {
    static var previews: some View {
        WeaponList()
            .environment(\.managedObjectContext, DataController().container.viewContext)
            .environmentObject(MainViewModel())
    }
}

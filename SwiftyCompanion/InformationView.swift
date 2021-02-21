//
//  InformationView.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 15/02/2021.
//

import SwiftUI

struct InformationView: View {
    let login: String
    
    var body: some View {
        let user = getUser(login: login)
        List {
            user.getImage()?
                .resizable()
                .scaledToFill()
            Section(header: Text("Details")) {
                HStack {
                    Label("Email", systemImage: "envelope")
                    Spacer()
                    Text(user.email!)
                }
                HStack {
                    Label("Level", systemImage: "42.circle")
                    Spacer()
                    Text(String(user.cursus_users![0].level!))
                }
                HStack {
                    Label("Location", systemImage: "mappin")
                    Spacer()
                    Text("\(user.campus![0].city!)/\(user.campus![0].country!)")
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text(login))
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(login: "norminet")
    }
}

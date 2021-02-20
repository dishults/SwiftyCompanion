//
//  InformationView.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 15/02/2021.
//

import SwiftUI

struct InformationView: View {
    @Binding var login: String
    
    var body: some View {
        let user = User(login: login)
        List {
            user.profilePicture
                .resizable()
                .scaledToFill()
            Section(header: Text("Details")) {
                HStack {
                    Label("Email", systemImage: "envelope")
                    Spacer()
                    Text(user.email)
                }
                HStack {
                    Label("Level", systemImage: "42.circle")
                    Spacer()
                    Text(String(user.level))
                }
                HStack {
                    Label("Location", systemImage: "mappin")
                    Spacer()
                    Text("\(user.campus["city"]!)/\(user.campus["country"]!)")
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text(login))
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
        InformationView(login: .constant("norminet"))
    }
}

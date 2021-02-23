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
        if let user = getUser(login: login) {
            List {
                user.getImage()?
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
                        Text(String(user.cursus_users[0].level))
                    }
                    HStack {
                        Label("Location", systemImage: "mappin")
                        Spacer()
                        Text("\(user.campus[0].city)/\(user.campus[0].country)")
                    }
                }
                Section(header: Text("Skills")) {
                    ForEach(user.cursus_users) { cursus_user in
                        if !cursus_user.skills.isEmpty {
                            ForEach(cursus_user.skills) { skill in
                                HStack {
                                    Text(skill.name)
                                    Spacer()
                                    Text(String(skill.level))
                                }
                            }
                        }
                    }
                }
                Section(header: Text("Projects")) {
                    ForEach(user.projects_users) { project in
                        if project.status == "finished" {
                            HStack {
                                Text(project.project.name)
                                Spacer()
                                Text(String(project.final_mark ?? 0))
                            }
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle(Text(login))
        } else {
            Text("No such user, try another one.")
        }
    }
}

struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
//        InformationView(login: "norminet")
        InformationView(login: "dshults")
//        InformationView(login: "test")
//        InformationView(login: "nonuser")
    }
}

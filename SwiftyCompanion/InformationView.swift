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
                Section(header:
                            HStack {
                                Spacer()
                                Text("Details").font(.headline)
                                Spacer()
                            }
                ) {
                    HStack {
                        Label("Email", systemImage: "envelope")
                        Spacer()
                        Text(user.email)
                    }
                    HStack {
                        Label("Location", systemImage: "mappin")
                        Spacer()
                        Text("\(user.campus[0].city)/\(user.campus[0].country)")
                    }
                }
                Section(header:
                            VStack {
                                Text("Skills and Projects").font(.headline)
                                HStack {
                                    Text("Cursus").padding(.leading)
                                    Spacer()
                                    Text("Level").padding(.trailing)
                                }
                            }
                ) {
                    let cursusUsers = user.cursus_users.filter { !$0.skills.isEmpty }
                    if !cursusUsers.isEmpty {
                        ForEach(cursusUsers.sorted { $0.level > $1.level }) { cursusUser in
                            if !cursusUser.skills.isEmpty {
                                NavigationLink(destination: SkillsAndProjectsView(cursusUser: cursusUser, projectUser: user.projects_users)) {
                                    Text(String(cursusUser.cursus.name))
                                    Spacer()
                                    Text(String(cursusUser.level))
                                }
                            }
                        }
                    } else { Text("No skills/projects yet") }
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

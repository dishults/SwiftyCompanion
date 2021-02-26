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
                                Text("Skills").font(.headline)
                                HStack {
                                    Text("Cursus").padding(.leading)
                                    Spacer()
                                    Text("Level").padding(.trailing)
                                }
                            }
                ) {
                    ForEach(user.cursus_users.sorted { $0.level > $1.level }) { cursusUser in
                        if !cursusUser.skills.isEmpty {
                            NavigationLink(destination: SkillsView(cursusUser: cursusUser)) {
                                Text(String(cursusUser.cursus.name))
                                Spacer()
                                Text(String(cursusUser.level))
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

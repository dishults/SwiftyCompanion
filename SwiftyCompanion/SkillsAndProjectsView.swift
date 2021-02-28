//
//  SkillsView.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 26/02/2021.
//

import SwiftUI

struct SkillsAndProjectsView: View {
    var cursusUser: CursusUser
    var projectUser: [ProjectsUser]

    var body: some View {
        List {
            Section(header:
                VStack {
                    Text("Skills").font(.headline)
                    HStack {
                        Text("Skill").padding(.leading)
                        Spacer()
                        Text("Level").padding(.trailing)
                    }
                }
            ) {
                ForEach(cursusUser.skills) { skill in
                    HStack {
                        Text(skill.name)
                        Spacer()
                        Text(String(skill.level))
                    }
                }
            }
            Section(header:
                VStack {
                    Text("Finished Projects").font(.headline)
                    HStack {
                        Text("Project").padding(.leading)
                        Spacer()
                        Text("Level").padding(.trailing)
                    }
                }
            ) {
                let cursusID = cursusUser.cursus.id
                let filtered = projectUser.filter { $0.cursusIDS.contains(where: { $0 == cursusID }) }
                ForEach(filtered) { project in
                    if project.status == "finished" {
                        HStack {
                            Text(project.project.name).foregroundColor(project.getColor())
                            Spacer()
                            Text(String(project.finalMark ?? 0))
                        }
                    }
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text(String(cursusUser.cursus.name)), displayMode: .inline)
    }
}

struct SkillsAndProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        let user = getTestUser(login: "dshults", group: DispatchGroup())!
        SkillsAndProjectsView(cursusUser: user.cursus_users[0], projectUser: user.projects_users)
        SkillsAndProjectsView(cursusUser: user.cursus_users[1], projectUser: user.projects_users)
        SkillsAndProjectsView(cursusUser: user.cursus_users[2], projectUser: user.projects_users)
    }
}

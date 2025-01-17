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
            // MARK: - Skills section
            Section(header:
                VStack {
                    Text("Skills").font(customHeadline())
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
                .font(customBody())
            }

            // MARK: - Finished Projects section
            Section(header:
                VStack {
                    Text("Finished Projects").font(customHeadline())
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
                .font(customBody())
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text(String(cursusUser.cursus.name)), displayMode: .inline)
    }
}

struct SkillsAndProjectsView_Previews: PreviewProvider {
    static var previews: some View {
        let user = getTestUser(login: "dshults")!
        ForEach(0...user.cursus_users.count - 1, id: \.self) { n in
            SkillsAndProjectsView(cursusUser: user.cursus_users[n], projectUser: user.projects_users)
        }
    }
}

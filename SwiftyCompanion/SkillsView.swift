//
//  SkillsView.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 26/02/2021.
//

import SwiftUI

struct SkillsView: View {
    var cursusUser: CursusUser

    var body: some View {
        List {
            Section(header:
                        HStack {
                            Text("Skill").padding(.leading)
                            Spacer()
                            Text("level").padding(.trailing)
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
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text(String(cursusUser.cursus.name)))
    }
}

struct SkillsView_Previews: PreviewProvider {
    static var previews: some View {
        let user = getUser(login: "dshults")!
        SkillsView(cursusUser: user.cursus_users[2])
    }
}

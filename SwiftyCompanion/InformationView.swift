//
//  InformationView.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 15/02/2021.
//

import SwiftUI


struct InformationView: View {
    let login: String
    @Binding var oauth2: OAuth2

    var body: some View {
        if let token = oauth2.token {
            if let user = oauth2.getUser(login: login) {
                proceed(user: user, login: login, token: token)
            } else {
                Text("No such user, try another one.")
            }
        } else {
            if let user = getTestUser(login: login) {
                proceed(user: user, login: login, token: nil)
            } else {
                Text("No such user, try another one.")
            }
        }
    }
}


struct proceed: View {
    let user: User
    let login: String
    let token: Token?
    let group = DispatchGroup()
    
    var body: some View {
        List {
            user.getImage(token: token)?
                .resizable().scaledToFill()
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            showDetails(user: user)
            showSkillsAndProjects(user: user)
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle(Text(login))
    }
}


struct showDetails: View {
    let user: User

    var body: some View {
        Section(header:
                        HStack {
                            Spacer()
                            Text("Details").font(customHeadline())
                            Spacer()
                        }
        ) {
            HStack {
                Label("Email", systemImage: "envelope")
                Spacer()
                Text(user.email)
            }
            
            let activeCampus = user.campus.filter { $0.active == true }
            ForEach(activeCampus) { campus in
                HStack {
                    Label("Campus", systemImage: "graduationcap")
                    Spacer()
                    Text(" \(campus.city), \(campus.country)")
                    }
                }
            HStack {
                Label("Piscine", systemImage: "terminal")
                Spacer()
                Text("\(user.pool_month ?? "") \(user.pool_year ?? "")")
            }
        }
        .font(.system(size: 18, design: .rounded))
    }
}

struct showSkillsAndProjects: View {
    let user: User

    var body: some View {
        Section(header:
                    VStack {
                        Text("Skills and Projects").font(customHeadline())
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
                .font(customBody())
            } else { Text("No skills/projects yet") }
        }
    }
}


struct InformationView_Previews: PreviewProvider {
    static var previews: some View {
//        InformationView(login: "norminet", oauth2: .constant(OAuth2())).preferredColorScheme(.light)
        InformationView(login: "dshults", oauth2: .constant(OAuth2())).preferredColorScheme(.light)
//        InformationView(login: "test", oauth2: .constant(OAuth2())).preferredColorScheme(.light)
//        InformationView(login: "nonuser", oauth2: .constant(OAuth2())).preferredColorScheme(.light)
    }
}

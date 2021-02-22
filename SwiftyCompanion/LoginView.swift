//
//  ContentView.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 15/02/2021.
//

import SwiftUI

struct LoginView: View {
    @State private var login: String = ""

    var body: some View {
        NavigationView {
                VStack {
                    Text("Hi! Please, enter a login to search")
                        .padding()
                    HStack {
                        TextField("Login", text: $login)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                        NavigationLink(destination: InformationView(login: login)) {
                            Image(systemName: "magnifyingglass")
                                .accessibilityLabel(Text("Search 42 student by login"))
                    }
                    .disabled(login.isEmpty)
                }
                .padding(.horizontal)
            }
            .navigationBarTitle(Text("SwiftyCompanion"))
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

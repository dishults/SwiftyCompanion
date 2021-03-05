//
//  ContentView.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 15/02/2021.
//

import SwiftUI


struct LoginView: View {
    @State private var login = ""
    @State private var isEditing = false
    @State private var oauth2 = OAuth2()

    init(getToken: Bool = true) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Arial Rounded MT Bold", size: 40)!]
        if getToken {
            self.oauth2.getToken()
        }
    }

    var body: some View {
        NavigationView {
            VStack {
                // MARK: - 42 image and welcome message
                Image("logo_42").resizable().scaledToFill().frame(width: /*@START_MENU_TOKEN@*/150.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/150.0/*@END_MENU_TOKEN@*/).offset(y: -50)
                VStack {
                    Text("Hi and welcome!")
                    Text("Please, enter a login to search")
                }
                .font(.custom("Bradley Hand", size: 25))
                .padding(.bottom, 30.0)

                // MARK: - TextField
                TextField("Login", text: $login, onEditingChanged: { isEditing in self.isEditing = isEditing })
                    .padding(7)
                    .padding(.horizontal, 25)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .overlay(
                        HStack {
                            Image(systemName: "magnifyingglass")
                                .foregroundColor(.gray)
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 8)
                     
                            if !login.isEmpty {
                                Button(action: {
                                    self.login = ""
                                }) {
                                    Image(systemName: "multiply.circle.fill")
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 8)
                                }
                            }
                        }
                    )
                    .padding(.horizontal, 15)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                // MARK: - Search button
                NavigationLink(destination: InformationView(login: login, oauth2: $oauth2)) {
                    Text("Search")
                        .accessibilityLabel(Text("Search 42 student by login"))
                }
                .padding(.top)
                .disabled(login.isEmpty)
            }
            .navigationBarTitle(Text("SwiftyCompanion"))
            .navigationBarHidden(isEditing)
        }
    }
}


struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView(getToken: false)
    }
}

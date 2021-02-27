//
//  ContentView.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 15/02/2021.
//

import SwiftUI


struct LoginView: View {
    @State private var login: String = ""
    @State private var isEditing = false
    
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Arial Rounded MT Bold", size: 40)!]
    }

    var body: some View {
        NavigationView {
            VStack {
                Image("logo_42").resizable().padding(.bottom, 30.0).frame(width: /*@START_MENU_TOKEN@*/150.0/*@END_MENU_TOKEN@*/, height: /*@START_MENU_TOKEN@*/150.0/*@END_MENU_TOKEN@*/).offset(y: -50)
                VStack {
                    Text("Hi and welcome!")
                    Text("Please, enter a login to search")
                }
                .font(.custom("Bradley Hand", size: 25))
                .padding(.bottom, 30.0)
                HStack {
                    TextField("Login", text: $login)
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
                    }
                NavigationLink(destination: InformationView(login: login)) {
                    Text("Search")
                        .accessibilityLabel(Text("Search 42 student by login"))
                }
                .padding(.top)
                .disabled(login.isEmpty)
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

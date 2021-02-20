//
//  User.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 19/02/2021.
//

import SwiftUI

class User {
    var login: String = ""
    var profilePicture: Image = Image(systemName: "moon")
    var email: String = ""
    var level: Float = 0.0
    var campus = ["city": "", "country": ""]

    init(login: String) {
        self.login = login
        (self.profilePicture, self.email, self.level, self.campus) = getUser(login: login)
    }

    func getUser(login: String) -> (profilePicture: Image, email: String, level: Float, location: [String: String]) {
        return (Image(login), "\(login)@students.42.fr", 12.21, ["city": "Paris", "country": "France"])
    }
}

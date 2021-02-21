//
//  User.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 19/02/2021.
//

import SwiftUI

struct User: Codable {
    
    let login, email: String?
    var image_url: String?
    let cursus_users: [Cursus]?
    let campus: [Campus]?
    
    func getImage() -> Image? {
        guard let pathString = Bundle.main.path(forResource: self.login!, ofType: "jpg") else {
            fatalError("login.jpg not found")
        }
        return Image(uiImage: UIImage(named: pathString)!)
    }
}

struct Cursus: Codable {
    let level: Float?
}

struct Campus: Codable {
    let city, country: String?
}


func getUser(login: String) -> User {
    guard let pathString = Bundle.main.path(forResource: login, ofType: "json") else {
        fatalError("login.json not found")
    }
    guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
        fatalError("Unable to convert login.json to String")
    }

    guard let jsonData = jsonString.data(using: .utf8) else {
        fatalError("Unable to convert login.json to Data")
    }

    guard let jsonDictionary = try? JSONDecoder().decode(User.self, from: jsonData) else {
        fatalError("Unable to convert login.json to JSON dictionary")
    }
    return jsonDictionary
}

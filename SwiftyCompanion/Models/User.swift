//
//  User.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 19/02/2021.
//

import SwiftUI

struct User: Codable {
    let login, email, image_url: String
    let pool_month, pool_year: String?
    let cursus_users: [CursusUser]
    let campus: [Campus]
    let projects_users: [ProjectsUser]
    
    func getImage() -> Image? {
        guard let pathString = Bundle.main.path(forResource: self.login, ofType: "jpg") else {
            fatalError("login.jpg not found")
        }
        return Image(uiImage: UIImage(named: pathString)!)
    }
}


struct CursusUser: Codable, Identifiable {
    let id: Int
    let level: Float
    let skills: [Skills]
    let cursus: Cursus
}


struct Campus: Codable, Identifiable {
    let id: Int
    let city, country: String
    let active: Bool
}


struct Skills: Codable, Identifiable {
    var id: Int
    let name: String
    let level: Float
}


struct Cursus: Codable {
    let id: Int
    let name: String
}


struct ProjectsUser: Codable, Identifiable {
    let id: Int
    let finalMark: Int?
    let status: String
    let validated: Bool?
    let project: Project
    let cursusIDS: [Int]

    enum CodingKeys: String, CodingKey {
        case id
        case finalMark = "final_mark"
        case status
        case validated = "validated?"
        case project
        case cursusIDS = "cursus_ids"
    }

    func getColor() -> Color {
        if self.validated == true {
            return Color.green
        } else {
            return Color.red
        }
    }
}


struct Project: Codable {
    let name: String
}


func getUser(login: String) -> User? {
    guard let pathString = Bundle.main.path(forResource: login, ofType: "json") else { return nil }
    guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else { return nil }
    guard let jsonData = jsonString.data(using: .utf8) else { return nil }
    guard let jsonDictionary = try? JSONDecoder().decode(User.self, from: jsonData) else { return nil }
    return jsonDictionary
}

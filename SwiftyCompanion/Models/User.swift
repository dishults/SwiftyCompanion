//
//  User.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 19/02/2021.
//

import SwiftUI

struct User: Codable {
    
    let login, email: String
    var image_url: String
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

struct CursusUser: Identifiable, Codable {
    let id: Int
    let level: Float
    let skills: [Skills]
    let cursus: Cursus
}

struct Campus: Codable {
    let city, country: String
}

struct Skills: Identifiable, Codable {
    var id: Int
    let name: String
    let level: Float
}
/*
 "id": 27262,
 "id": 21310,
 "id": 83610,
 */
struct Cursus: Codable {
    let name: String
}

struct ProjectsUser: Identifiable, Codable {
    let id: Int
    let final_mark: Int?
    let status: String
    let validated: Bool?
    let project: Project

    enum CodingKeys: String, CodingKey {
        case id
        case final_mark
        case status
        case validated = "validated?"
        case project
    }
}

struct Project: Codable {
    let name: String
}


func getUser(login: String) -> User? {
    //FIXME: Change to -> do catch
    guard let pathString = Bundle.main.path(forResource: login, ofType: "json") else {
       return nil
    }
    guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else {
        return nil
    }

    guard let jsonData = jsonString.data(using: .utf8) else {
        return nil
    }

    guard let jsonDictionary = try? JSONDecoder().decode(User.self, from: jsonData) else {
        return nil
    }
    return jsonDictionary
}

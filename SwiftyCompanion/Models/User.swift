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
    let correction_point: Int?
    let campus: [Campus]
    let cursus_users: [CursusUser]
    let projects_users: [ProjectsUser]
    
    func getImage(token: Token?) -> Image? {
        let group = DispatchGroup()
        var image: Image?

        // MARK: - Get image for Preview
        if token == nil {
            guard let pathString = Bundle.main.path(forResource: self.login, ofType: "jpg") else {
                fatalError("login.jpg not found")
            }
            image = Image(uiImage: UIImage(named: pathString)!)

        // MARK: - Get image for 42 API
        } else {
            let url = URL(string: image_url)!
            
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(token!.access_token)", forHTTPHeaderField: "Authorization")
            
            group.enter()
            URLSession.shared.dataTask(with: request) { data, response, error in
                guard let data = data else {
                    print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                    group.leave()
                    return
                }
                image = Image(uiImage: UIImage(data: data)!)
                group.leave()
            }.resume()
            group.wait()
        }
        return image
    }
}


// MARK: - Campus
struct Campus: Codable, Identifiable {
    let id: Int
    let city, country: String
    let active: Bool
}


// MARK: - CursusUser
struct CursusUser: Codable, Identifiable {
    let id: Int
    let level: Float
    let skills: [Skills]
    let cursus: Cursus
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


// MARK: - ProjectsUser
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


// MARK: - Get test User for Preview
func getTestUser(login: String) -> User? {
    guard let pathString = Bundle.main.path(forResource: login, ofType: "json") else { return nil }
    guard let jsonString = try? String(contentsOfFile: pathString, encoding: .utf8) else { return nil }
    guard let jsonData = jsonString.data(using: .utf8) else { return nil }
    guard let jsonDictionary = try? JSONDecoder().decode(User.self, from: jsonData) else { return nil }
    return jsonDictionary
}

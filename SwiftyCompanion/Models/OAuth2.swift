//
//  OAuth2.swift
//  SwiftyCompanion
//
//  Created by Dmytro Shults on 21/02/2021.
//

import Foundation

class OAuth2 {
    let tokenURL = URL(string: "https://api.intra.42.fr/oauth/token")!
    let userURL = "https://api.intra.42.fr/v2/users/"
    let UID = "UID"
    let secret = "SECRET"
    var token: Token?

    func getToken() {
        var request = URLRequest(url: tokenURL)
        let params = "grant_type=client_credentials&client_id=\(UID)&client_secret=\(secret)"
        request.httpMethod = "POST"
        request.httpBody = Data(params.utf8)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            if let decodedToken = try? JSONDecoder().decode(Token.self, from: data) {
                self.token = decodedToken
            } else {
                print("Invalid response from server")
            }
        }.resume()
    }
    
    func getUser(login: String, group: DispatchGroup) -> User? {
        let url = URL(string: "\(userURL)\(login)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token!.access_token)", forHTTPHeaderField: "Authorization")

        var user: User?
        group.enter()
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                group.leave()
                return
            }
            if let decodedUser = try? JSONDecoder().decode(User.self, from: data) {
                user = decodedUser
            } else {
                print("Invalid response from server")
            }
            group.leave()
        }.resume()
        group.wait()
        return user
    }
}


struct Token: Decodable {
    let access_token, token_type, scope: String
    let expires_in, created_at: Int
}

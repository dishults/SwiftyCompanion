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
        let group = DispatchGroup()
        var request = URLRequest(url: tokenURL)
        let params = "grant_type=client_credentials&client_id=\(UID)&client_secret=\(secret)"
        request.httpMethod = "POST"
        request.httpBody = Data(params.utf8)

        group.enter()
        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                group.leave()
                return
            }
            if let decodedToken = try? JSONDecoder().decode(Token.self, from: data) {
                self.token = decodedToken
                let dateFromResponse = (response as? HTTPURLResponse)!.value(forHTTPHeaderField: "Date")!
                self.token!.setExpirationDate(dateFromResponse: dateFromResponse)
            } else {
                print("Invalid response from server")
            }
            group.leave()
        }.resume()
        group.wait()
    }
    
    func checkAndRenewToken() {
        if token != nil && token!.expirationDate! > Date() {
            print("Token is still valid.")
        } else {
            token = nil
            print("Token has expired. Will try to renew it.")
            getToken()
            if token != nil && token!.expirationDate! > Date() {
                print("Token has been renewed successfully.")
            } else {
                print("Failed to renew the token.")
            }
        }
    }

    func getUser(login: String) -> User? {
        let group = DispatchGroup()
        let url = URL(string: "\(userURL)\(login)")!
        checkAndRenewToken()
        
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
    let expires_in, created_at: TimeInterval
    var expirationDate: Date?
    
    mutating func setExpirationDate(dateFromResponse: String) {
        let formatter = DateFormatter()
        // "Fri, 05 Mar 2021 16:45:19 GMT"
        formatter.dateFormat = "E, d MMM y HH:mm:ss z"
        let date = formatter.date(from: dateFromResponse) ?? Date()
        // expires_in counts from dateFromResponse which isn't always equal to created_at
        expirationDate = date + expires_in
    }
}

//
//  API.swift
//  Danting
//
//  Created by 김은상 on 10/28/24.
//

import UIKit

enum Request {
    
}

class API {
    func registerUser(user: User, completion: @escaping (String?) -> Void) {
        guard let url_registerUser = URL(string: "http://localhost:8080/join") else {
            print("Debug: Failled to generate URL")
            completion(nil)
            return
        }
        
        var request = URLRequest(url: url_registerUser)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        

        do {
            let jsonData = try JSONEncoder().encode(user)
            request.httpBody = jsonData
        } catch {
            print("Debug: Failed to encoding Json Data..\n\(error)")
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Debug: Failed to request \n\(error)")
                completion(nil)
                return
            }
            
            guard let data = data else {
                print("Debug: Data doesn't exist..")
                completion(nil)
                return
            }
            
            do {
                if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                   let userId = json["user_id"] as? String {
                    completion(userId)
                } else {
                    print("Debug: Failed to parsing user_id..")
                    completion(nil)
                }
            } catch {
                print("Debug: Json Parsing Error \n\(error)")
                completion(nil)
            }
        }.resume()
    }
    
    
    
}

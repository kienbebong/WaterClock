//
//  API.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 12/11/24.
//

import Foundation

struct Constants {
    static let API_KEY = "http://kh.emic.com.vn/api"
}

class API {
    static let shared = API()
    
    func checkLogin(userName: String, password: String, completion: @escaping (Result<Account, Error>) -> Void) {
        guard let url = URL(string: "\(Constants.API_KEY)/Login?UserAccount=\(userName)&Password=\(password)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
            
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
            do {
                let account = try JSONDecoder().decode(Account.self, from: data)
                completion(.success(account))
            } catch {
                completion(.failure(error))
            }
        }
            
            task.resume()
    }
}

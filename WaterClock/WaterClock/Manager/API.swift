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
            
//            if let dataString = String(data: data, encoding: .utf8) {
//                        print("Response data: \(dataString)")
//                    }
            
            do {
                let account = try JSONDecoder().decode(Account.self, from: data)
                completion(.success(account))
            } catch {
                completion(.failure(error))
            }
        }
            
            task.resume()
    }
    
    func getDataInDay(date: String, meterNo: String, token: String, completion: @escaping (Result<[MeterDataInDay], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.API_KEY)/GetMeterDataInDay?MeterNo=\(meterNo)&Date=\(date)&Token=\(token)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
                do {
                    let result = try JSONDecoder().decode([MeterDataInDay].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
        }
        
        task.resume()
    }
    
    func getInstantByDate(startDate: String, endDate: String, meterNo: String, token: String, completion: @escaping (Result<[InstantByDate], Error>) -> Void){
        
        guard let url = URL(string: "\(Constants.API_KEY)/GetInstantByDate?MeterNo=\(meterNo)&StartDate=\(startDate)&EndDate=\(endDate)&Token=\(token)") else {
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil else {
                return
            }
            
//            if let dataString = String(data: data, encoding: .utf8) {
//                print("Response data: \(dataString)")
//            }

                do {
                    let result = try JSONDecoder().decode([InstantByDate].self, from: data)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
        }
        
        task.resume()
    }
}

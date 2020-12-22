//
//  Service.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import Foundation

protocol Service {
    func getGenericData<T: Decodable>(url: URL?, completion: @escaping (T?, APIError?) -> Void)
}

class ServiceImplementation: Service {
    func getGenericData<T>(url: URL?, completion: @escaping (T?, APIError?) -> Void) where T: Decodable {
        if let url = url {
            URLSession.shared.dataTask(with: url) { (data, resp, err) in
                if let err = err {
                    print("Failed to fetch data:", err)
                    completion(nil, APIError.badRequest)
                    return
                }
                
                guard let data = data else {
                    completion(nil, APIError.jsonError)
                    return
                }
                
                do {
                    let genericData = try JSONDecoder().decode(T.self, from: data)
                    completion(genericData, nil)
                } catch let jsonErr {
                    completion(nil, APIError.jsonError)
                    print("Failed to decode json:", jsonErr)
                   }
                }.resume()
        } else {
            completion(nil, APIError.nonValidURL)
        }
    }
}

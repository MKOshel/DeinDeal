//
//  URLBuilder.swift
//  DDTest
//
//  Created by Dragos Marinescu on 12/17/20.
//

import Foundation

struct APIPath {
    static let scheme = "http"
    static let baseURL = "testfoodios.herokuapp.com"
}

struct Endpoint {
    let path: String
    let queryItems: [URLQueryItem]?
}

extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = APIPath.scheme
        components.host = APIPath.baseURL
        components.path = path
        components.queryItems = queryItems
        
        return components.url
    }
}

//
//  NetworkReachability.swift
//  Mobile Developer Test
//
//  Created by kjoe on 12/28/20.
//

import Foundation
protocol Endpoint {
    var path: String { get set}
    var queryItems: [URLQueryItem]? { get set}
}
extension Endpoint {
    var url: URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "hn.algolia.com"
        components.path = path
        components.queryItems = queryItems
        return components.url
    }
}

struct ListEndpoint:Endpoint{
    var path: String
    var queryItems: [URLQueryItem]?    
    
}

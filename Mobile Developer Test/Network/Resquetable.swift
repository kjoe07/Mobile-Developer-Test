//
//  NetworkReachability.swift
//  Mobile Developer Test
//
//  Created by kjoe on 12/28/20.
//

import Foundation
struct Resquetable{
    func createRequest(endPoint: Endpoint) throws -> URLRequest{
        print("url:",endPoint.url)
        guard let url = endPoint.url else {throw customError.badRequest}
            let request = URLRequest(url: url)
            return request
    }
}

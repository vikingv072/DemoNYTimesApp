//
//  URLRequest+Extension.swift
//  NYTimes
//
//  Created by Kevin Varghese on 12/12/21.
//

import Foundation

extension URLRequest {
    static func getRequest(url: String, path: String) -> Self? {
        guard var urlComponents = URLComponents(string: url.appending(path)) else {
            return nil
        }
        
        urlComponents.queryItems = [URLQueryItem(name: "api-key", value: ServiceEndPoint.key)]
        guard let url = urlComponents.url else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        return request
    }
}

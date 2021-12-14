//
//  NewsService.swift
//  NYTimes
//
//  Created by Kevin Varghese on 12/12/21.
//

import Foundation
import Combine

enum ServiceError: Error {
    case errorWith(message: String)
}

protocol NewsService  {
    func get(urlRequest: URLRequest) -> AnyPublisher<Data, ServiceError>
}

class NewsServiceImp: NewsService {
    func get(urlRequest: URLRequest) -> AnyPublisher<Data, ServiceError> {
        return URLSession.shared
            .dataTaskPublisher(for: urlRequest)
            .tryMap{ response -> Data in
                guard let httpResonse = response.response as? HTTPURLResponse, httpResonse.statusCode == 200 else {
                    throw ServiceError.errorWith(message: "Something went wrong")
                }
                
                return response.data
            }
            .mapError{ _ in ServiceError.errorWith(message: "Something went wrong")}
            .eraseToAnyPublisher()
    }
}



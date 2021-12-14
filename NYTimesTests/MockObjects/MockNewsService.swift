//
//  MockNewsService.swift
//  NYTimesTests
//
//  Created by Kevin Varghese on 12/12/21.
//

import Foundation
import Combine
@testable import NYTimes

class MockNewsService: NewsService {
    
    func get(urlRequest: URLRequest) -> AnyPublisher<Data, ServiceError> {
        
        return URLSession.shared
            .dataTaskPublisher(for: Bundle(for: type(of: self)).url(forResource: "TopStoriesMockData", withExtension: "json")!)
            .tryMap { response -> Data in
                return response.data
            }.mapError { _ in
                return ServiceError.errorWith(message: "Example Error")
            }.eraseToAnyPublisher()
    }
    
}

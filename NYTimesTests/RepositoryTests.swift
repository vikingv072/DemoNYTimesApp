//
//  RepositoryTest.swift
//  NYTimesTests
//
//  Created by Kevin Varghese on 12/12/21.


import XCTest
import Combine
@testable import NYTimes

class RepositoryTests: XCTestCase {

    var repository: RepositoryImpl?
    var subscriptions: Set<AnyCancellable> = []
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        self.repository = RepositoryImpl(newsService: MockNewsService())
    }

    override func tearDownWithError() throws {
        self.repository = nil
        try super.tearDownWithError()
    }

    
    func testFetchNewsSuccessfully() {
        let expectation = XCTestExpectation(description: "Successfully fetched top stories")
        var topStories: TopStories?
        
        self.repository?.fetchNews(modelType: TopStories.self)
            .receive(on: DispatchQueue.main).sink{ _ in
                expectation.fulfill()
            }
            receiveValue: { response in
                topStories = response
                
            }.store(in: &subscriptions)
        
        wait(for: [expectation], timeout: 3)
        
        XCTAssertEqual(topStories?.results.count, 34)
        XCTAssertEqual(topStories?.results.first?.title, "What Did Stephen Sondheim Really Think of ‘Rent’?")
        XCTAssertEqual(topStories?.results.first?.byline, "By Evelyn McDonnell")
        XCTAssertEqual(topStories?.results.first?.updatedDate, "2021-12-13T21:25:36-05:00")
    }

}

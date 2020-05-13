//
//  ChannelsWebRepositoryTests.swift
//  MindValleyTests
//
//  Created by Agustín Prats Hernandez on 13/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import XCTest
import Combine
@testable import MindValley

final class ChannelsWebRepositoryTests: XCTestCase {
    
    private var sut: RealChannelsWebRepository!
    private var subscriptions = Set<AnyCancellable>()
    
    typealias API = RealChannelsWebRepository.API
    typealias Mock = RequestMocking.MockedResponse

    override func setUp() {
        subscriptions = Set<AnyCancellable>()
        sut = RealChannelsWebRepository(session: .mockedResponsesOnly,
                                        baseURL: "https://test.com")
    }

    override func tearDown() {
        RequestMocking.removeAllMocks()
    }
    
    func test_newEpisodes() throws {
        let data = NewEpisodesData.mockedData
        try mock(.newEpisodes, result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.loadNewEpisodes().sinkToResult { result in
            result.assertSuccess(value: data)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_channels() throws {
        let data = ChannelsData.mockedData
        try mock(.channels, result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.loadChannels().sinkToResult { result in
            result.assertSuccess(value: data)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_categories() throws {
        let data = CategoriesData.mockedData
        try mock(.categories, result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.loadCategories().sinkToResult { result in
            result.assertSuccess(value: data)
            exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    // MARK: - Helper
    
    private func mock<T>(_ apiCall: API, result: Result<T, Swift.Error>,
                         httpCode: HTTPCode = 200) throws where T: Encodable {
        let mock = try Mock(apiCall: apiCall, baseURL: sut.baseURL, result: result, httpCode: httpCode)
        RequestMocking.add(mock: mock)
    }
}

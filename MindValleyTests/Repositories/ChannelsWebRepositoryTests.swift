//
//  ChannelsWebRepositoryTests.swift
//  MindValleyTests
//
//  Copyright © 2020 Agustín Prats.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

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
        sut.loadNewEpisodes()
            .discardErrors
            .sink {
                guard $0 != nil else { return }
                exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_channels() throws {
        let data = ChannelsData.mockedData
        try mock(.channels, result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.loadChannels()
            .discardErrors
            .sink {
                guard $0 != nil else { return }
                exp.fulfill()
        }.store(in: &subscriptions)
        wait(for: [exp], timeout: 2)
    }
    
    func test_categories() throws {
        let data = CategoriesData.mockedData
        try mock(.categories, result: .success(data))
        let exp = XCTestExpectation(description: "Completion")
        sut.loadCategories()
            .discardErrors
            .sink {
                guard $0 != nil else { return }
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

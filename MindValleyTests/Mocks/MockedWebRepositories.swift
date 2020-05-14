//
//  MockedWebRepositories.swift
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

class TestWebRepository: WebRepository {
    let session: URLSession = .mockedResponsesOnly
    let baseURL = "https://pastebin.com"
    let bgQueue = DispatchQueue(label: "test")
}

// MARK: - ChannelsWebRepository

final class MockedChannelsWebRepository: TestWebRepository, Mock, ChannelsWebRepository {
    
    enum Action: Equatable {
        case loadNewEpisodes
        case loadChannels
        case loadCategories
    }
    var actions = MockActions<Action>(expected: [])
    
    var newEpisodesResponse: Result<NewEpisodesData, Error> = .failure(MockError.valueNotSet)
    var channelsResponse: Result<ChannelsData, Error> = .failure(MockError.valueNotSet)
    var categoriesResponse: Result<CategoriesData, Error> = .failure(MockError.valueNotSet)
    
    func loadNewEpisodes() -> AnyPublisher<NewEpisodesData, Error> {
        register(.loadNewEpisodes)
        return newEpisodesResponse.publish()
    }
    
    func loadChannels() -> AnyPublisher<ChannelsData, Error> {
        register(.loadChannels)
        return channelsResponse.publish()
    }
    
    func loadCategories() -> AnyPublisher<CategoriesData, Error> {
        register(.loadCategories)
        return categoriesResponse.publish()
    }
}

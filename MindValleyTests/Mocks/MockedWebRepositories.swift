//
//  MockedWebRepositories.swift
//  UnitTests
//
//  Created by Alexey Naumov on 31.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

import XCTest
import Combine
@testable import MindValley

class TestWebRepository: WebRepository {
    let session: URLSession = .mockedResponsesOnly
    let baseURL = "https://pastebin.com"
    let bgQueue = DispatchQueue(label: "test")
}

// MARK: - CountriesWebRepository

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

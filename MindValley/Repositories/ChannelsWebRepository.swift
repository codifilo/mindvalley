//
//  NewEpisodesRepository.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 13/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import Foundation
import Combine

protocol ChannelsWebRepository: WebRepository {
    func loadNewEpisodes() -> AnyPublisher<NewEpisodesData, Error>
    func loadChannels() -> AnyPublisher<ChannelsData, Error>
    func loadCategories() -> AnyPublisher<CategoriesData, Error>
}

struct RealChannelsWebRepository: ChannelsWebRepository {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_episodes_parse_queue")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadNewEpisodes() -> AnyPublisher<NewEpisodesData, Error>  {
        call(endpoint: API.newEpisodes)
    }
    
    func loadChannels() -> AnyPublisher<ChannelsData, Error> {
        call(endpoint: API.channels)
    }
    
    func loadCategories() -> AnyPublisher<CategoriesData, Error> {
        call(endpoint: API.categories)
    }
}

// MARK: - Endpoints

extension RealChannelsWebRepository {
    enum API {
        case newEpisodes
        case channels
        case categories
    }
}

extension RealChannelsWebRepository.API: APICall {
    var path: String {
        switch self {
        case .newEpisodes:
            return "/raw/z5AExTtw"
        case .channels:
            return "/raw/Xt12uVhM"
        case .categories:
            return "/raw/A0CgArX3"
        }
    }
    var method: String {
        switch self {
        case .newEpisodes:
            return "GET"
        case .channels:
            return "GET"
        case .categories:
            return "GET"
        }
    }
    var headers: [String: String]? {
        return ["Accept": "application/json"]
    }
    func body() throws -> Data? {
        return nil
    }
}

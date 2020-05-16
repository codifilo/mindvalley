//
//  NewEpisodesRepository.swift
//  MindValley
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

import Foundation
import Combine

protocol ChannelsWebRepository: WebRepository {
    func loadNewEpisodes() -> AnyPublisher<NewEpisodesData?, Error>
    func loadChannels() -> AnyPublisher<ChannelsData?, Error>
    func loadCategories() -> AnyPublisher<CategoriesData?, Error>
}

struct RealChannelsWebRepository: ChannelsWebRepository {
    let session: URLSession
    let baseURL: String
    let bgQueue = DispatchQueue(label: "bg_episodes_parse_queue")
    let fileCache = FileCache(cacheName: "RealChannelsWebRepositoryCache")
    
    init(session: URLSession, baseURL: String) {
        self.session = session
        self.baseURL = baseURL
    }
    
    func loadNewEpisodes() -> AnyPublisher<NewEpisodesData?, Error> {
        cachedCall(endpoint: API.newEpisodes)
    }
    
    func loadChannels() -> AnyPublisher<ChannelsData?, Error> {
        cachedCall(endpoint: API.channels)
    }
    
    func loadCategories() -> AnyPublisher<CategoriesData?, Error> {
        cachedCall(endpoint: API.categories)
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

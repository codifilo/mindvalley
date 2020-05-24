//
//  ChannelsInteractor.swift
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

protocol ChannelsInteractor {
    func loadAll()
    func loadNewEpisodes()
    func loadChannels()
    func loadCategories()
}

final class RealChannelsInteractor: ChannelsInteractor {
    let appState: Store<AppState>
    let webRepository: ChannelsWebRepository
    private var cancellables = Set<AnyCancellable>()
    
    init(appState: Store<AppState>, webRepository: ChannelsWebRepository) {
        self.appState = appState
        self.webRepository = webRepository
        loadAll()
    }
    
    func loadAll() {
        loadNewEpisodes()
        loadChannels()
        loadCategories()
    }
    
    func loadNewEpisodes() {
        appState[\.userData.newEpisodes].setIsLoading()
        webRepository.loadNewEpisodes().sink(
            receiveCompletion: {
                if case .failure(let error) = $0 {
                    self.appState[\.userData.newEpisodes] = .failed(error)
                }
        },
            receiveValue: {
                self.appState[\.userData.newEpisodes] = .loaded($0.data.media)
        }).store(in: &cancellables)
    }
    
    func loadChannels() {
        appState[\.userData.channels].setIsLoading()
        webRepository.loadChannels().sink(
            receiveCompletion: {
                if case .failure(let error) = $0 {
                    self.appState[\.userData.channels] = .failed(error)
                }
        },
            receiveValue: {
                self.appState[\.userData.channels] = .loaded($0.data.channels)
        }).store(in: &cancellables)
    }
    
    func loadCategories() {
        appState[\.userData.categories].setIsLoading()
        webRepository.loadCategories().sink(
            receiveCompletion: {
                if case .failure(let error) = $0 {
                    self.appState[\.userData.categories] = .failed(error)
                }
        },
            receiveValue: {
                self.appState[\.userData.categories] = .loaded($0.data.categories)
        }).store(in: &cancellables)
    }
}

struct StubChannelsInteractor: ChannelsInteractor {
    func loadAll() {}
    func loadNewEpisodes() {}
    func loadChannels() {}
    func loadCategories() {}
}

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

struct RealChannelsInteractor: ChannelsInteractor {
    let appState: Store<AppState>
    let webRepository: ChannelsWebRepository
    
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
        let cancelBag = CancelBag()
        appState[\.userData.newEpisodes].setIsLoading(cancelBag: cancelBag)
        webRepository.loadNewEpisodes().sink(
            receiveCompletion: {
                if case .failure(let error) = $0 {
                    self.appState[\.userData.newEpisodes] = .failed(error)
                }
        },
            receiveValue: {
                guard let value = $0 else { return }
                self.appState[\.userData.newEpisodes] = .loaded(value.data.media)
        }).store(in: cancelBag)
    }
    
    func loadChannels() {
        let cancelBag = CancelBag()
        appState[\.userData.channels].setIsLoading(cancelBag: cancelBag)
        webRepository.loadChannels().sink(
            receiveCompletion: {
                if case .failure(let error) = $0 {
                    self.appState[\.userData.channels] = .failed(error)
                }
        },
            receiveValue: {
                guard let value = $0 else { return }
                self.appState[\.userData.channels] = .loaded(value.data.channels)
        }).store(in: cancelBag)
    }
    
    func loadCategories() {
        let cancelBag = CancelBag()
        appState[\.userData.categories].setIsLoading(cancelBag: cancelBag)
        webRepository.loadCategories().sink(
            receiveCompletion: {
                if case .failure(let error) = $0 {
                    self.appState[\.userData.categories] = .failed(error)
                }
        },
            receiveValue: {
                guard let value = $0 else { return }
                self.appState[\.userData.categories] = .loaded(value.data.categories)
        }).store(in: cancelBag)
    }
}

struct StubChannelsInteractor: ChannelsInteractor {
    func loadAll() {}
    func loadNewEpisodes() {}
    func loadChannels() {}
    func loadCategories() {}
}

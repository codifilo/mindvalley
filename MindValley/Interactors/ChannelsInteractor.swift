//
//  ChannelsInteractor.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 13/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import Foundation
import Combine

protocol ChannelsInteractor {
    func refresh()
}

struct RealChannelsInteractor: ChannelsInteractor {
    let appState: Store<AppState>
    let webRepository: ChannelsWebRepository
    
    init(appState: Store<AppState>, webRepository: ChannelsWebRepository) {
        self.appState = appState
        self.webRepository = webRepository
        refresh()
    }
    
    func refresh() {
        loadCategories()
    }
    
    private func loadCategories() {
        let cancelBag = CancelBag()
        appState[\.userData.categoriesData].setIsLoading(cancelBag: cancelBag)
        webRepository.loadCategories().sink(
            receiveCompletion: {
                if case .failure(let error) = $0 {
                    self.appState[\.userData.categoriesData] = .failed(error)
                }
        },
            receiveValue: {
                self.appState[\.userData.categoriesData] = .loaded($0)
        }).store(in: cancelBag)
    }
}

struct StubChannelsInteractor: ChannelsInteractor {
    func refresh() {}
}

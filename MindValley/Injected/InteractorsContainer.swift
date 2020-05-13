//
//  DIContainer.Interactors.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 24.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

extension DIContainer {
    struct Interactors {
        let newEpisodesInteractor: NewEpisodesInteractor
        let channelsInteractor: ChannelsInteractor
        let categoriesInteractor: CategoriesInteractor
        
        init(newEpisodesInteractor: NewEpisodesInteractor,
             channelsInteractor: ChannelsInteractor,
             categoriesInteractor: CategoriesInteractor) {
            self.newEpisodesInteractor = newEpisodesInteractor
            self.channelsInteractor = channelsInteractor
            self.categoriesInteractor = categoriesInteractor
        }
        
        static var stub: Self {
            .init(newEpisodesInteractor: StubNewEpisodesInteractor(),
                  channelsInteractor: StubChannelsInteractor(),
                  categoriesInteractor: StubCategoriesInteractor())
        }
    }
}

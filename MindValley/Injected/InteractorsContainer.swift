//
//  DIContainer.Interactors.swift
//  CountriesSwiftUI
//
//  Created by Alexey Naumov on 24.10.2019.
//  Copyright © 2019 Alexey Naumov. All rights reserved.
//

extension DIContainer {
    struct Interactors {
        let channels: ChannelsInteractor
        
        init(channelsInteractor: ChannelsInteractor) {
            self.channels = channelsInteractor
        }
        
        static var stub: Self {
            .init(channelsInteractor: StubChannelsInteractor())
        }
    }
}

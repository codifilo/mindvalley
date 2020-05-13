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
}

struct RealChannelsInteractor: ChannelsInteractor {
    let webRepository: ChannelsWebRepository
}

struct StubChannelsInteractor: ChannelsInteractor {
}

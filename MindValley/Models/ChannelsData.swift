//
//  ChannelsData.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 13/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import Foundation

struct ChannelsData: Codable, Equatable {
    let data: Data
}

extension ChannelsData {
    struct Data: Codable, Equatable {
        let channels: [Channel]
    }
}

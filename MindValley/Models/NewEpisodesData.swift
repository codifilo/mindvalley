//
//  NewEpisodesData.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 13/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import Foundation

struct NewEpisodesData: Codable, Equatable {
    let data: Data
}

extension NewEpisodesData {
    struct Data: Codable, Equatable {
        let media: [Media]
    }
}

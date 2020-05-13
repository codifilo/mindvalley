//
//  Course.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 13/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import Foundation

struct Media: Codable, Equatable {
    let title: String
    let coverAsset: CoverAsset
    let channel: Channel
}

extension Media {
    struct Channel: Codable, Equatable {
        let title: String
    }
}

//
//  Course.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 13/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import Foundation

struct Media: Codable, Equatable {
    let type: Type
    let title: String
    let coverAsset: Asset
    let channel: Channel?
}

extension Media {
    enum `Type`: String, Codable, Equatable {
        case course = "course"
        case video = "video"
    }
}

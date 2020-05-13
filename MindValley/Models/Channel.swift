//
//  Channel.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 13/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import Foundation

struct Channel: Codable, Equatable {
    let title: String
    let coverAsset: Asset?
    let iconAsset: Asset?
    let mediaCount: Int?
    let id: Int?
    let series: [SeriesItem]?
    let latestMedia: [Media]?
}

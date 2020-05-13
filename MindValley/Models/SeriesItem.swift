//
//  SeriesItem.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 13/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import Foundation

struct SeriesItem: Codable, Equatable {
    let title: String
    let id: String?
    let coverAsset: Asset
}

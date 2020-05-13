//
//  CategoriesData.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 13/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import Foundation

struct CategoriesData: Codable, Equatable {
    let data: Data
}

extension CategoriesData {
    struct Data: Codable, Equatable {
        let categories: [Category]
    }
}

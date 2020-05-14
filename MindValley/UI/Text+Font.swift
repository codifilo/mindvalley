//
//  Font+Theme.swift
//  MindValley
//
//  Created by Agustín Prats Hernandez on 14/05/2020.
//  Copyright © 2020 Agustín Prats Hernandez. All rights reserved.
//

import SwiftUI

extension Text {
    var headline: Text {
        font(.custom("Roboto-Bold", size: 20))
            .foregroundColor(Color.tertiaryText)
    }
    
    var category: Text {
        font(.custom("Roboto-Bold", size: 18))
            .foregroundColor(Color.white)
    }
}

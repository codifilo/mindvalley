//
//  String+Localization.swift
//  HeartPeace
//
//  Created by Agustín Prats Hernandez on 27/10/2019.
//  Copyright © 2019 Agustín Prats. All rights reserved.
//

import Foundation

extension String {
    var localized: String {
        NSLocalizedString(self, comment: "")
    }
    
    func localize(with parameters: CVarArg...) -> String {
        return String(format: self.localized, locale: nil, arguments: parameters)
    }
}

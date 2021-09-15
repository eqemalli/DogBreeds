//
//  Strings+Localizations.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import Foundation

public extension String {
    
    func localized(comment: String = "") -> Self {
        return NSLocalizedString(self, comment: comment)
    }
    
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    func lowercasedFirstLetter() -> String {
        return prefix(1).lowercased() + dropFirst()
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

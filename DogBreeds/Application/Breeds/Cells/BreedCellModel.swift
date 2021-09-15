//
//  BreedCellModel.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import Foundation
import Combine

public class BreedCellModel {
    // MARK: - Properties
    
    public var title: CurrentValueSubject<String?, Never>
    public var didTap: (() -> ())?
    
    public init(title: String?, didTap: (() -> ())?) {
        self.title = CurrentValueSubject(title)
        self.didTap = didTap
    }
}

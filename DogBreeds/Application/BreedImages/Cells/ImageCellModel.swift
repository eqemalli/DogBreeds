//
//  ImageCellModel.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import UIKit
import Combine

public class ImageCellModel {
    // MARK: - Properties
    
    public var breedImage: CurrentValueSubject<String, Never>
    public var favoriteImage: CurrentValueSubject<UIImage?, Never>
    
    public init(breedImage: String, favoriteImage: UIImage? = UIImage()) {
        self.breedImage = CurrentValueSubject(breedImage)
        self.favoriteImage = CurrentValueSubject(favoriteImage)
    }
}

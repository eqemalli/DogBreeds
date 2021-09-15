//
//  UIImageView.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 15.9.21.
//
import SDWebImage
import UIKit

extension UIImageView {
    func setImage(url: String) {
        sd_imageTransition = .fade
        sd_setImage(with: URL(string: url), completed: nil)
    }
}

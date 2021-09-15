//
//  BreedsCoordinator.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import Foundation
import UIKit

class BreedsCoordinator {
    
    // MARK: - Properties
    
    public private(set) var root: UINavigationController
    // MARK: - Initializers
    
    public init(root: UINavigationController = UINavigationController()) {
        self.root = root
    }
    
    // MARK: - Instance functions
    
    @discardableResult
    public func start() -> UIViewController {
        let viewModel = BreedsViewModel(coordinator: self)
        let viewController = BreedsViewController(viewModel: viewModel)
        root.viewControllers = [viewController]
        return root
    }
    
    /**
     Present the airport selection
     */
    func presentBreedImagesViewController(title: String){
        let viewModel = BreedImagesViewModel(coordinator: self, breed: title)
        let viewController = BreedImagesViewController(viewModel: viewModel)
        viewController.title = title
        root.pushViewController(viewController, animated: true)
    }
}

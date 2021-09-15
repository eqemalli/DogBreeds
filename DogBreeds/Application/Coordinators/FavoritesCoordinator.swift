//
//  FavoritesCoordinator.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import Foundation
import UIKit

class FavoritesCoordinator {
    
    // MARK: - Properties
    
    public private(set) var root: UINavigationController
    
    // MARK: - Initializers
    
    public init(root: UINavigationController = UINavigationController()) {
        self.root = root
    }
    
    // MARK: - Instance functions
    
    @discardableResult
    public func start() -> UIViewController {
        let viewModel = FavoritesViewModel(coordinator: self)
        let viewController = FavoritesViewController(viewModel: viewModel)
        viewController.title = "Favorite"
        root.viewControllers = [viewController]
        return root
    }
    
}

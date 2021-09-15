//
//  MainAppCoordinator.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import Foundation
import UIKit

class MainAppCoordinator {
    
    // MARK: - Properties
    
    private(set) var root: MainTabBarController
    
    private var breedsCoordinator: BreedsCoordinator?
    private var favoritesCoordinator: FavoritesCoordinator?
    
    // MARK: - Initializers
    
    /**
     Initialize the coordinator with a main root view controller
     - Parameter rootViewController: The root tab bar view controller
     */
    public init(rootViewController: MainTabBarController = MainTabBarController()) {
        root = rootViewController
    }
    
    // MARK: - Instance functions
    
    /**
     Setup views, root view controller and make key and visible
     - Parameter window: The window to set the root view controller and make key and visible
     - Parameter userActivity: A `NSUserActivity` to handle
     */
    func startAndMakeKeyAndRootViewController(of window: UIWindow?, userActivity: NSUserActivity? = nil) {
        
        let breedsCoordinator = BreedsCoordinator()
        let home = breedsCoordinator.start()
        let homeTabItem = UITabBarItem(title: "general_tab_home".localized(), image: UIImage(named: "icon-tab-dog"), selectedImage: UIImage(named: "icon-tab-dog-selected"))
        home.tabBarItem = homeTabItem
        self.breedsCoordinator = breedsCoordinator
        
        let favoritesCoordinator = FavoritesCoordinator()
        let favorites = favoritesCoordinator.start()
        let favoritesTabItem = UITabBarItem(title: "general_tab_favorites".localized(), image: UIImage(named: "icon-tab-favorite"), selectedImage: UIImage(named: "icon-tab-favorite-selected"))
        favorites.tabBarItem = favoritesTabItem
        self.favoritesCoordinator = favoritesCoordinator
        
        root.setupViewControllers([home, favorites])
        root.selectedIndex = 0
        
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }

}

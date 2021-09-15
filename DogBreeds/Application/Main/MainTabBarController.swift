//
//  MainTabBarController.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import Foundation
import UIKit

public class MainTabBarController: UITabBarController {
    
    // MARK: - Properties
    
    private(set) var tabBarIcons: TabBarIcons?
    
    // MARK: - Initializers
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    // MARK: - Override functions
    
    public override func loadView() {
        super.loadView()
    }
    
    // MARK: - Instance functions
    
    public func setupViewControllers(_ viewControllers: [UIViewController]?) {
        self.viewControllers = viewControllers
    }
    
}

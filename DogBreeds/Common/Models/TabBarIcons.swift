//
//  TabBarIcons.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import Foundation
import UIKit

public struct TabBarIcons {
    var home: SelectableIcon
    var favorites: SelectableIcon
}

public struct SelectableIcon {
    public var `default`: UIImage?
    public var selected: UIImage?
}

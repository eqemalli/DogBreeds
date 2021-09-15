//
//  Favorites.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 15.9.21.
//

import Foundation

struct Favorite: Decodable, Encodable {
    let image: String

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        image = try container.decode(String.self, forKey: CodingKeys.image)
    }
    
    enum CodingKeys: String, CodingKey {
        case image = "image"
        
    }
}


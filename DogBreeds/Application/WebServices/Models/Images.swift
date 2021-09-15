//
//  Images.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import Foundation

struct Images: Decodable {
    let message: [String]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode([String].self, forKey: CodingKeys.message)
    }
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        
    }
}

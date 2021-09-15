//
//  Breeds.swift
//  DogBreeds
//
//  Created by Enxhi Qemalli on 14.9.21.
//

import Foundation

struct BreedType: Decodable {
    let message: [String: [String]]

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        message = try container.decode([String: [String]].self, forKey: CodingKeys.message)
    }
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        
    }
}

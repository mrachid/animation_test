//
//  PhotoUrl.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation

struct PhotoUrl {
    let image: String
}

extension PhotoUrl: Decodable {
    enum PhotoUrlKeys: String, CodingKey {
        case image = "regular"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotoUrlKeys.self)
        image = try container.decode(String.self, forKey: .image)
    }
}


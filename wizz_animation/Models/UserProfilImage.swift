//
//  UserProfilImage.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation

struct UserProfilImage {
    let image: String?
}

extension UserProfilImage: Decodable {
    enum UserProfilImageKeys: String, CodingKey {
        case image = "large"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserProfilImageKeys.self)
        image = try container.decode(String.self, forKey: .image)
    }
}

//
//  User.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation

struct User {
    let username: String
    let profileImage: UserProfilImage?
}

extension User: Decodable {
    enum UserKeys: String, CodingKey {
        case username
        case profileImage = "profile_image"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: UserKeys.self)
        username = try container.decode(String.self, forKey: .username)
        profileImage = try container.decodeIfPresent(UserProfilImage.self, forKey: .profileImage)
    }
}

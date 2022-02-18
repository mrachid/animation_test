//
//  Photo.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation

struct Photo {
    let id: String
    let description: String?
    let altDescription: String?
    let urls: PhotoUrl?
    let likes: Int?
    let user: User
}

extension Photo: Decodable {
    enum PhotoKeys: String, CodingKey {
        case id
        case description
        case altDescription = "alt_description"
        case urls
        case likes
        case user
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotoKeys.self)
        id = try container.decode(String.self, forKey: .id)
        altDescription = try container.decodeIfPresent(String.self, forKey: .altDescription)
        description = try container.decodeIfPresent(String.self, forKey: .description)
        urls = try container.decodeIfPresent(PhotoUrl.self, forKey: .urls)
        likes = try container.decodeIfPresent(Int.self, forKey: .likes)
        user = try container.decode(User.self, forKey: .user)
    }
}

//
//  Statistics.swift
//  wizz_animation
//
//  Created by Rachid Mahmoud on 26/10/2021.
//

import Foundation

struct Statistics {
    let id: String
    let downloads: PhotoDownloads?
    let views: PhotoViews?
}

extension Statistics: Decodable {
    enum StatisticsKeys: String, CodingKey {
        case id
        case downloads
        case views
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StatisticsKeys.self)
        id = try container.decode(String.self, forKey: .id)
        downloads = try container.decodeIfPresent(PhotoDownloads.self, forKey: .downloads)
        views = try container.decodeIfPresent(PhotoViews.self, forKey: .views)
    }
}


struct PhotoDownloads {
    let total: Int?
}

extension PhotoDownloads: Decodable {
    enum PhotoDownloadsKeys: String, CodingKey {
        case total
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotoDownloadsKeys.self)
        total = try container.decode(Int.self, forKey: .total)
    }
}

struct PhotoViews {
    let total: Int?
}

extension PhotoViews: Decodable {
    enum PhotoViewsKeys: String, CodingKey {
        case total
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: PhotoViewsKeys.self)
        total = try container.decode(Int.self, forKey: .total)
    }
}

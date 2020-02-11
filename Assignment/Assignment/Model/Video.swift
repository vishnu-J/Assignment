//
//  Video.swift
//  Assignment
//
//  Created by Vishnu on 10/02/20.
//  Copyright © 2020 Vishnu. All rights reserved.
//

import Foundation

struct Video : Codable {
    let title : String?
    let url : String?
    let thumbnail : String?

    enum CodingKeys: String, CodingKey {
        case title = "title"
        case url = "hlsUrl"
        case thumbnail = "thumbnail"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        url = try values.decodeIfPresent(String.self, forKey: .url)
        thumbnail = try values.decodeIfPresent(String.self, forKey: .thumbnail)
    }

}

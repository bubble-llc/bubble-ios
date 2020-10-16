//
//  Comment.swift
//  Localist
//
//  Created by Steven Tran on 9/29/20.
//  Copyright © 2020 Localist. All rights reserved.
//

import Foundation

struct Comment: Decodable, Identifiable {
    var id = UUID()
    let content: String
    let username: String
    let date_created: String
    
    private enum CodingKeys: String, CodingKey {
            case id, content, username, date_created
        }
    
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(UUID.self, forKey: .id)
        content = try values.decode(String.self, forKey: .content)
        username = try values.decode(String.self, forKey: .username)
        date_created = try values.decode(String.self, forKey: .date_created)
    }

}

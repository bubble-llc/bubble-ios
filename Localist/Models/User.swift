//
//  User.swift
//  Localist
//
//  Created by Steven Tran on 10/18/20.
//  Copyright © 2020 Localist. All rights reserved.
//

import Foundation

struct User: Decodable {
    let username: String
    let email: String
    let date_joined: String
    
    private enum CodingKeys: String, CodingKey {
            case id, username, email, date_joined
        }
    
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        username = try values.decode(String.self, forKey: .username)
        email = try values.decode(String.self, forKey: .email)
        date_joined = try values.decode(String.self, forKey: .date_joined)
    }

}

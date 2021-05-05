//
//  Notification.swift
//  Bubble
//
//  Created by steven tran on 5/5/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import Foundation

struct Notification: Decodable, Identifiable {
    let id: Int
    let notification_type: String
    let content: String
    let is_viewed: Bool
    let date_created: String
    
    private enum CodingKeys: String, CodingKey {
            case id, notification_type, content, is_viewed, date_created
        }
    
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        notification_type = try values.decode(String.self, forKey: .notification_type)
        content = try values.decode(String.self, forKey: .content)
        is_viewed = try values.decode(Bool.self, forKey: .is_viewed)
        date_created = convert_date(try values.decode(String.self, forKey: .date_created))
    }
}

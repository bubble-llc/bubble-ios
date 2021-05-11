//
//  Constants.swift
//  Bubble
//
//  Created by steven tran on 4/7/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import Foundation

struct Constants {
    static let DEFAULT_USER_ID: Int = 0
    static let DEFAULT_CATEGORY: Int = 1
    static let DEFAULT_USER_TYPE: Int = 2
    static let avatar_list = ["avatar_black", "avatar_green", "avatar_purple", "avatar_orange"]
    static let category_list = ["Deals", "Happy Hour", "Recreation", "What's Happening?", "Misc"]
    
    
     static let DEFAULT_HTTP_HEADER_FIELDS: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]

 }

enum ActiveAlert {
    case blockUser, confirmComment, sameUserBlock, sameUserReport
}

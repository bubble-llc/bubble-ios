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
    static let defaults = UserDefaults.standard
    static let current_user_id = UserDefaults.standard.string(forKey: defaultsKeys.user_id)!
    /*
     The RGB codes are reference only. When calling a color use the actual name, such as:
     Color("bubble_blue")
     Color("bubble_dark")
     Colors:
     bubble_blue: Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
     bubble_dark: Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255)
     
     */
     static let DEFAULT_HTTP_HEADER_FIELDS: [String: String] = [
        "Content-Type": "application/json",
        "Accept": "application/json"
    ]

 }

enum ActiveAlert {
    case blockUser, confirmComment, sameUserBlock, sameUserReport, deletePost, deleteComment
}

enum PasswordAlert {
    case misMatch, empty, success
}

enum StandardAlert {
    case empty, duplicate
}

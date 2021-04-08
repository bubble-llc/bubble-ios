//
//  UserInfo.swift
//  Bubble
//
//  Created by Steven Tran on 12/10/20.
//  Copyright © 2020 Bubble. All rights reserved.
//
import Foundation
import Combine

class UserAuth: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    var isLoggedin:Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        let defaults = UserDefaults.standard
        let user_id = defaults.integer(forKey: defaultsKeys.user_id)
        if user_id != Constants.DEFAULT_USER_ID
        {
            self.isLoggedin = true
        }
        else
        {
            self.isLoggedin = false
        }
    }
    
    func setInfo(userInfo: Dictionary<String, String>) {
        let defaults = UserDefaults.standard
        defaults.set(userInfo["username"], forKey: defaultsKeys.username)
        defaults.set(userInfo["user_id"], forKey: defaultsKeys.user_id)
        defaults.set(userInfo["user_type"], forKey: defaultsKeys.user_type)
        defaults.set(userInfo["password"], forKey: defaultsKeys.password)
        defaults.set(userInfo["email"], forKey: defaultsKeys.email)
        defaults.set(userInfo["date_joined"], forKey: defaultsKeys.date_joined)
        defaults.set(userInfo["default_category_id"], forKey: defaultsKeys.default_category_id)
        self.isLoggedin = true
    }
    
    func logout() {
        let defaults = UserDefaults.standard
        defaults.set("username", forKey: defaultsKeys.username)
        defaults.set(Constants.DEFAULT_USER_ID, forKey: defaultsKeys.user_id)
        defaults.set(Constants.DEFAULT_USER_TYPE, forKey: defaultsKeys.user_type)
        defaults.set("password", forKey: defaultsKeys.password)
        defaults.set("email", forKey: defaultsKeys.email)
        defaults.set("date_joined", forKey: defaultsKeys.date_joined)
        defaults.set(Constants.DEFAULT_CATEGORY, forKey: defaultsKeys.default_category_id)
        self.isLoggedin = false
    }
}

struct defaultsKeys {
    static let username = "username"
    static let user_id = "user_id"
    static let user_type = "user_type"
    static let password = "password"
    static let email = "email"
    static let date_joined = "date_joined"
    static let default_category_id = "default_category_id"
}

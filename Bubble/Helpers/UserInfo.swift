//
//  UserInfo.swift
//  Bubble
//
//  Created by Steven Tran on 12/10/20.
//  Copyright © 2020 Bubble. All rights reserved.
//
import Foundation
import Combine
import JWTDecode
import SwiftKeychainWrapper

class UserAuth: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    var isLoggedin:Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        let user_id = KeychainWrapper.standard.string(forKey: defaultsKeys.user_id) ?? ""
        if user_id != ""
        {
            self.isLoggedin = true
        }
        else
        {
            self.isLoggedin = false
        }
    }
    
    func processJwt(jwt: Jwt, password: String) {
        let decoded_jwt = try? decode(jwt: jwt.token)
        let body = decoded_jwt!.body
        let defaults = UserDefaults.standard
        defaults.set(body["username"], forKey: defaultsKeys.username)
        defaults.set(password, forKey: defaultsKeys.password)
        defaults.set(body["email"], forKey: defaultsKeys.email)
        defaults.set(body["date_joined"], forKey: defaultsKeys.date_joined)
        defaults.set(body["default_category_id"], forKey: defaultsKeys.default_category_id)
        KeychainWrapper.standard.set(body["user_id"] as! String, forKey: defaultsKeys.user_id)
        KeychainWrapper.standard.set(body["user_type"] as! String, forKey: defaultsKeys.user_type)
        KeychainWrapper.standard.set(password, forKey: defaultsKeys.password)
        KeychainWrapper.standard.set(jwt.token, forKey: defaultsKeys.token)
        self.isLoggedin = true
    }
    
    func logout() {
        let defaults = UserDefaults.standard
        defaults.set("username", forKey: defaultsKeys.username)
        defaults.set("email", forKey: defaultsKeys.email)
        defaults.set("date_joined", forKey: defaultsKeys.date_joined)
        defaults.set(Constants.DEFAULT_CATEGORY, forKey: defaultsKeys.default_category_id)
        KeychainWrapper.standard.removeObject(forKey: defaultsKeys.user_id)
        KeychainWrapper.standard.removeObject(forKey: defaultsKeys.user_type)
        KeychainWrapper.standard.removeObject(forKey: defaultsKeys.password)
        KeychainWrapper.standard.removeObject(forKey: defaultsKeys.token)
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
    static let token = "token"
    static let radius = "radius"
}

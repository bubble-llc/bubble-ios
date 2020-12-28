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
        let username = defaults.string(forKey: defaultsKeys.username)!
        if username != "username"
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
        defaults.set(userInfo["password"], forKey: defaultsKeys.password)
        defaults.set(userInfo["email"], forKey: defaultsKeys.email)
        defaults.set(userInfo["date_joined"], forKey: defaultsKeys.date_joined)
        self.isLoggedin = true
    }
    
    func logout() {
        let defaults = UserDefaults.standard
        defaults.set("username", forKey: defaultsKeys.username)
        defaults.set("password", forKey: defaultsKeys.password)
        defaults.set("email", forKey: defaultsKeys.email)
        defaults.set("date_joined", forKey: defaultsKeys.date_joined)
        self.isLoggedin = false
    }
}

struct defaultsKeys {
    static let username = "username"
    static let password = "password"
    static let email = "email"
    static let date_joined = "date_joined"
}

//
//  Login.swift
//  Localist
//
//  Created by Steven Tran on 11/9/20.
//  Copyright © 2020 Localist. All rights reserved.
//

import Foundation


class UserAuth: ObservableObject {
    let didChange = PassthroughSubject<UserAuth,Never>()

      // required to conform to protocol 'ObservableObject'
    let willChange = PassthroughSubject<UserAuth,Never>()

    @State private var showingAlert = false
       
    @Published var isLoggedin: Bool = false
        
    func login(username: String, password: String, users: [User]) -> Bool{
     
        API().getUser(username: username, password:  password){ (users) in
            if(users.count != 0)
            {
                
                let defaults = UserDefaults.standard
                defaults.set(username, forKey: defaultsKeys.username)
                defaults.set(password, forKey: defaultsKeys.password)
                defaults.set(users[0].email, forKey: defaultsKeys.email)
                defaults.set(users[0].date_joined, forKey: defaultsKeys.date_joined)
                self.isLoggedin = true
            }
            else
            {
                self.showingAlert = true
            }
        
        }
        return self.isLoggedin
    }
}

class GlobalLogin: ObservableObject {
  @Published var isLoggedIn = false
}

struct defaultsKeys {
    static let username = "username"
    static let password = "password"
    static let email = "email"
    static let date_joined = "date_joined"
}

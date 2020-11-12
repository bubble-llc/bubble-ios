//
//  CreateUserView.swift
//  Localist
//
//  Created by Steven Tran on 9/26/20.
//  Copyright © 2020 Localist. All rights reserved.
//

//TODO
/*
    Successful button click takes you to main screen
        - Validate successful response
        - Pop current screen
 */
import SwiftUI

struct CreateUserView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var email: String = ""
    @State private var termsAccepted = false

    var body: some View {
            Form {
                TextField("Username", text: self.$username).autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                SecureField("Password", text: self.$password)
                TextField("Email", text: self.$email).autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                Toggle(isOn: $termsAccepted,
                       label: {
                           Text("Accept terms and conditions")
                })
                
                if self.isUserInformationValid() {
                    Button(action: {
                        let postObject: [String: Any]  =
                            [
                                "username": self.$username.wrappedValue,
                                "password": self.$password.wrappedValue,
                                "email": self.$email.wrappedValue
                            ]
                        API().createUser(submitted: postObject)
                        
                        if let window = UIApplication.shared.windows.first {
                            window.rootViewController = UIHostingController(rootView: ContentView())
                            window.makeKeyAndVisible()
                        }
                    }, label: {
                        Text("Create")
                    })
                }
            }.navigationBarTitle(Text("Create User"))
    }
    
    private func isUserInformationValid() -> Bool {
        if username.isEmpty {
            return false
        }
        
        if password.isEmpty {
            return false
        }
        
        if email.isEmpty {
            return false
        }
        
        if !termsAccepted {
            return false
        }
        
        return true
    }
}

struct CreateUserView_Previews: PreviewProvider {
    static var previews: some View {
        CreateUserView()
    }
}

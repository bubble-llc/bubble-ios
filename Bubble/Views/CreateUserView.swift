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
    
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var categoryGlobal: Category

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
                                "user_type": 2,
                                "password": self.$password.wrappedValue,
                                "email": self.$email.wrappedValue
                            ]
                        API().createUser(submitted: postObject)
                        
                        if let window = UIApplication.shared.windows.first {
                            window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(userAuth).environmentObject(categoryGlobal))
                            window.makeKeyAndVisible()
                        }
                    }, label: {
                        Text("Create")
                    })
                }
            }.navigationBarTitle(Text("Create User"))
    }
    
    private func isUserInformationValid() -> Bool {
        if username.isEmpty || password.isEmpty || email.isEmpty || !termsAccepted{
            return false
        }
        else
        {
            return true
        }
    }
}


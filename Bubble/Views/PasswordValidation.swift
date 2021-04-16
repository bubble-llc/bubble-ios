//
//  PasswordValidation.swift
//  Bubble
//
//  Created by steven tran on 4/16/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI

struct PasswordValidation: View {
    @Binding var email: String
    
    @State private var password: String = ""
    @State private var validationCode: String = ""
    
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var categoryGlobal: Category

    var body: some View {
            Form {
                TextField("Validation Code", text: self.$validationCode)
                SecureField("Password", text: self.$password)
                Button(action: {
                    let postObject: [String: Any]  =
                        [
                            "password": self.$password.wrappedValue,
                            "email": self.$email.wrappedValue,
                            "validation_code": self.$validationCode.wrappedValue
                        ]
                    API().validatePasswordReset(submitted: postObject)
                    if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UIHostingController(rootView: ContentView().environmentObject(userAuth).environmentObject(categoryGlobal))
                        window.makeKeyAndVisible()
                    }
                }, label: {
                    Text("Reset Password?")
                })
            }.navigationBarTitle(Text("Reset Password"))
    }
}

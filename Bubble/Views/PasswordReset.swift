//
//  PasswordReset.swift
//  Bubble
//
//  Created by steven tran on 4/16/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI

struct PasswordReset: View {
    @State private var email: String = ""
    @State var showLoginView: Bool = false
    
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var categoryGlobal: Category

    var body: some View {
        VStack {
            if showLoginView {
                PasswordValidation(email: self.$email).environmentObject(userAuth).environmentObject(categoryGlobal)
            }
            else {
                Form {
                    TextField("Email", text: self.$email).autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    Button("Forgot Password") {
                        let postObject: [String: Any]  =
                            [
                                "email": self.$email.wrappedValue
                            ]
                        API().passwordReset(submitted: postObject)
                        self.showLoginView = true
                    }
                }
            }
        }
    }
}

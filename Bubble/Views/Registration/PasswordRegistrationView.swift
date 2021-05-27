//
//  PasswordRegistrationView.swift
//  Bubble
//
//  Created by steven tran on 5/13/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI

struct PasswordRegistrationView: View {
    @Binding var username: String
    @Binding var email: String
    
    @State private var password: String = ""
    @State private var showCompleteRegistation = false
    
    var body: some View {
        ZStack{
            NavigationLink(
                "showCompleteRegistation", destination: CompleteRegistationView(username: $username, email: $email, password: $password),
                isActive: $showCompleteRegistation
            )
            Rectangle()
              .fill(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
              .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Spacer()
                Group{
                    Spacer()
                    Spacer()
                    Text("Create a Password").foregroundColor(.white)
                    Spacer()
                    HStack {
                        Image(systemName: "lock").foregroundColor(.white)
                        
                        ZStack(alignment: .leading) {
                                if password.isEmpty {
                                    Text("Password")
                                        .foregroundColor(.white)
                                }
                                SecureField("", text: $password, onCommit: {
                                    showCompleteRegistation = true
                                })
                                    .keyboardType(.webSearch)
                            }
                        
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.white))
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    Spacer()
                    Text("Enter a combination of at least six numbers, letters and special characters")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                    Spacer()
                    Spacer()
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Divider().background(Color(red: 220 / 255, green: 220 / 255, blue: 220 / 255))
                Button("Already have an account?", action: {
                    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                })
                    .font(.headline)
                    .padding()
                    .cornerRadius(10)
                .foregroundColor(.white)
            }
            .navigationBarBackButtonHidden(true)
        }
    }
}

//
//  EmailRegistrationView.swift
//  Bubble
//
//  Created by steven tran on 5/13/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI

struct EmailRegistrationView: View {
    @Binding var username: String
    
    @State private var email: String = ""
    @State private var showPasswordRegistation = false
    @State private var showingAlert = false
    @State private var activeAlert: StandardAlert = .empty
    var body: some View {
        ZStack{
            NavigationLink(
                "showPasswordRegistation", destination: PasswordRegistrationView(username: $username, email: $email),
                isActive: $showPasswordRegistation
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
                    Text("What’s your email address?").foregroundColor(.white)
                    Spacer()
                    HStack {
                        Image(systemName: "mail").foregroundColor(.white)
                        
                        ZStack(alignment: .leading) {
                                if email.isEmpty {
                                    Text("Email")
                                        .foregroundColor(.white)
                                }
                                TextField("", text: $email, onCommit: {
                                    if(email.isEmpty){
                                        self.showingAlert = true
                                        activeAlert = .empty
                                    }
                                    else{
                                        API().checkEmail(email: email)
                                        { (result) in
                                            switch result
                                            {
                                                case .success():
                                                    self.showingAlert = false
                                                    showPasswordRegistation = true
                                                case .failure(let error):
                                                    print(error)
                                                    self.showingAlert = true
                                                    activeAlert = .duplicate
                                            }
                                        }
                                    }
                                })
                                    .keyboardType(.webSearch)
                                    .alert(isPresented:$showingAlert){
                                        switch activeAlert{
                                            case .empty:
                                                return Alert(title: Text("Please enter email"),
                                                             message: Text(""),
                                                             dismissButton: .default(Text("OK"), action: {}))
                                            case .duplicate:
                                                return Alert(title: Text("Email already exist"),
                                                             message: Text(""),
                                                             dismissButton: .default(Text("OK"), action: {}))
                                        }
                                    }
                            }
                        
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.white))
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    Spacer()
                    Text("This will be used to reset your password and verify your account")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                    Spacer()
                    Spacer()
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Divider().background(Color.white)
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

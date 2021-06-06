//
//  PasswordRegistrationView.swift
//  Bubble
//
//  Created by steven tran on 5/13/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI

struct PasswordRegistrationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var username: String
    @Binding var email: String
    
    @State private var password: String = ""
    @State private var newPassword: String = ""
    @State private var confirmPassword: String = ""
    @State private var showCompleteRegistation = false
    
    @State private var showingAlert = false
    @State private var activeAlert: PasswordAlert = .misMatch
    
    var btnBack : some View { Button(action: {
        self.presentationMode.wrappedValue.dismiss()
        }) {
            HStack {
            Image("ic_back") // set image here
                .aspectRatio(contentMode: .fit)
                .foregroundColor(.white)
                Text("Back")
            }
        }
    }
    
    var body: some View {
        ZStack{
            NavigationLink(
                "showCompleteRegistation", destination: CompleteRegistationView(username: $username, email: $email, password: $newPassword),
                isActive: $showCompleteRegistation
            )
            Rectangle()
              .fill(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
              .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Spacer()
                Group{
                    Text("Create a New Password").foregroundColor(.white)
                    Spacer()
                    HStack {
                        Image(systemName: "lock").foregroundColor(.white)
                        
                        ZStack(alignment: .leading) {
                                if newPassword.isEmpty {
                                    Text("New Password")
                                        .foregroundColor(.white)
                                }
                                SecureField("", text: $newPassword)
                                    .keyboardType(.webSearch)
                            }
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.white))
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    HStack {
                        Image(systemName: "lock").foregroundColor(.white)
                        ZStack(alignment: .leading) {
                                if confirmPassword.isEmpty {
                                    Text("Confirm Password")
                                        .foregroundColor(.white)
                                }
                                SecureField("", text: $confirmPassword)
                                    .keyboardType(.webSearch)
                            }
                        
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.white))
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    Spacer()
                    Button(action: {
                        print(newPassword)
                        print(confirmPassword)
                        if(newPassword.isEmpty && confirmPassword.isEmpty){
                            activeAlert = .empty
                            showingAlert = true
                        }
                        else if(newPassword == confirmPassword){
                            showCompleteRegistation = true
                        }
                        else{
                            activeAlert = .misMatch
                            showingAlert = true
                        }
                    }, label: {
                        HStack{
                            Spacer()
                            Text("Continue")
                                .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                            Spacer()
                        }

                    })
                    .alert(isPresented:$showingAlert){
                        switch activeAlert{
                            case .empty:
                                return Alert(title: Text("Please enter password"),
                                             message: Text(""),
                                             dismissButton: .default(Text("OK"), action: {}))
                            case .misMatch:
                                return Alert(title: Text("You passwords are different"),
                                             message: Text(""),
                                             dismissButton: .default(Text("OK"), action: {
                                                newPassword = ""
                                                confirmPassword = ""
                                             }))
                            case .success:
                                return Alert(title: Text("Success!"),
                                             message: Text("Your password has been updated"),
                                             dismissButton: .default(Text("OK"), action: {
                                                UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                                             }))
                        }
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                }
                Spacer()
                Text("Enter a combination of at least six numbers, letters and special characters")
                    .foregroundColor(.white)
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                Spacer()
                Spacer()
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(Text("Create Password"), displayMode: .inline)
            .navigationBarItems(
                leading: btnBack,
                trailing: Button(action: {
                    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                }, label: {
                    Text("Cancel")
                    .foregroundColor(.white)
                })
            )
        }
    }
}

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
    @State private var showPasswordValidation = false
    @State private var showingAlert = false
    @State private var activeAlert: StandardAlert = .empty
    
    var body: some View {
        NavigationView{
            ZStack{
                NavigationLink(
                    "showPasswordValidation", destination: PasswordValidation(email: $email),
                    isActive: $showPasswordValidation
                )
                Rectangle()
                  .fill(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                  .edgesIgnoringSafeArea(.all)
                VStack{
                    Group{
                        Spacer()
                        Spacer()
                        Text("We'll send you a code that confirms the account is yours")
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                        Spacer()
                        HStack {
                            Image(systemName: "person").foregroundColor(.white)
                            
                            ZStack(alignment: .leading) {
                                    if email.isEmpty {
                                        Text("Email")
                                            .foregroundColor(.white)
                                    }
                                    TextField("", text: $email)
                                }
                            
                        }
                        .foregroundColor(Color.white)
                        .padding()
                        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.white))
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        Spacer()
                        Button(action: {
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
                                            self.showingAlert = true
                                            activeAlert = .duplicate
                                        case .failure(let error):
                                            print(error)
                                            let postObject: [String: Any]  =
                                                [
                                                    "email": self.$email.wrappedValue
                                                ]
                                            API().passwordReset(submitted: postObject)

                                            self.showingAlert = false
                                            showPasswordValidation = true
                                    }
                                }
                            }
                        }, label: {
                            HStack{
                                Spacer()
                                Text("Continue")
                                    .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                                Spacer()
                            }
                        })
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                        .alert(isPresented:$showingAlert){
                            switch activeAlert{
                                case .empty:
                                    return Alert(title: Text("Please enter email"),
                                                 message: Text(""),
                                                 dismissButton: .default(Text("OK"), action: {}))
                                case .duplicate:
                                    return Alert(title: Text("Email does not exist"),
                                                 message: Text(""),
                                                 dismissButton: .default(Text("OK"), action: {}))
                            }
                        }
                        Spacer()
                        Spacer()
                    }
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                }
                .navigationBarItems(
                    trailing: Button(action: {
                        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                    }, label: {
                        Text("Cancel")
                        .foregroundColor(.white)
                    })
                )
                .navigationBarTitle(Text("Confirm Account"), displayMode: .inline)
            }
        }
    }
}

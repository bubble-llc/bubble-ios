//
//  CompleteRegistationView.swift
//  Bubble
//
//  Created by steven tran on 5/13/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI

struct CompleteRegistationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var username: String
    @Binding var email: String
    @Binding var password: String
    
    @State private var showingAlert = false
    
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
            Rectangle()
              .fill(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
              .edgesIgnoringSafeArea(.all)
            VStack{
                Spacer()
                Spacer()
                Group{
                    Spacer()
                    Spacer()
                    Text("Complete Registration").foregroundColor(.white)
                    Spacer()
                    Text("By tapping register, you agree to our terms, Data Policy and Cookies Policy.")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                    Spacer()
                    if #available(iOS 14.0, *) {
                        Link("View Our Terms of Service",
                             destination: URL(string: "https://www.termsfeed.com/live/ffdd0de8-f5d2-41db-9b04-b89bdd99f685")!)
                            .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                    } else {
                        // Fallback on earlier versions
                    }
                    Spacer()
                    HStack{
                        Spacer()
                        Button("Register", action: {
                            let postObject: [String: Any]  =
                                [
                                    "username": self.$username.wrappedValue,
                                    "user_type": 2,
                                    "password": self.$password.wrappedValue,
                                    "email": self.$email.wrappedValue
                                ]
                            API().createUser(submitted: postObject)
                            showingAlert = true
                        })
                        .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        .alert(isPresented:$showingAlert){
                            return Alert(title: Text("Congratulations!"),
                                         message: Text("Your account has been created. Please check your email to activate your account"),
                                         dismissButton: .default(Text("OK"), action: {
                                            UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                                         }))
                        }
                        Spacer()
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    Spacer()
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(Text("Complete Registration"), displayMode: .inline)
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
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
    }
}

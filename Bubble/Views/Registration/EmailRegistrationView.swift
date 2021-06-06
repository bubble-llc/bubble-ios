//
//  EmailRegistrationView.swift
//  Bubble
//
//  Created by steven tran on 5/13/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI

struct EmailRegistrationView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @Binding var username: String
    
    @State private var email: String = ""
    @State private var showPasswordRegistation = false
    @State private var showingAlert = false
    @State private var activeAlert: StandardAlert = .empty
    
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
                                        self.showingAlert = false
                                        showPasswordRegistation = true
                                    case .failure(let error):
                                        print(error)
                                        self.showingAlert = true
                                        activeAlert = .duplicate
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
                    Spacer()
                    Text("This will be used to reset your password and verify your account")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                    Spacer()
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle(Text("Validate Email"), displayMode: .inline)
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

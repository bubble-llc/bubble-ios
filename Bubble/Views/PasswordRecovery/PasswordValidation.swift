//
//  PasswordValidation.swift
//  Bubble
//
//  Created by steven tran on 4/16/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI

struct PasswordValidation: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var email: String
    
    @State private var recoveryCode: String = ""
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
                "showPasswordRegistation", destination: PasswordCreationView(email: $email, recoveryCode: $recoveryCode),
                isActive: $showPasswordRegistation
            )
            Rectangle()
              .fill(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
              .edgesIgnoringSafeArea(.all)
            VStack{
                Group{
                    Spacer()
                    Spacer()
                    Text("A code has been sent to your email address. Enter that code here")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                    Spacer()
                    HStack {
                        ZStack(alignment: .leading) {
                                if recoveryCode.isEmpty {
                                    Text("Enter Code")
                                        .foregroundColor(.white)
                                }
                                TextField("", text: $recoveryCode)
                            }
                        
                    }
                    .foregroundColor(Color.white)
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.white))
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    Spacer()
                    Button(action: {
                        if(recoveryCode.isEmpty){
                            self.showingAlert = true
                            activeAlert = .empty
                        }
                        API().validatePasswordRecoveryCode(email: email, recovery_code: recoveryCode)
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
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                    .alert(isPresented:$showingAlert){
                        switch activeAlert{
                            case .empty:
                                return Alert(title: Text("Please enter recovery code"),
                                             message: Text(""),
                                             dismissButton: .default(Text("OK"), action: {}))
                            case .duplicate:
                                return Alert(title: Text("Recovery code is invalid"),
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
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(
                leading: btnBack,
                trailing: Button(action: {
                    UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                }, label: {
                    Text("Cancel")
                    .foregroundColor(.white)
                })
            .navigationBarTitle(Text("Confirm Account"), displayMode: .inline)
            )
        }
    }
}

//
//  UsernameRegistrationView.swift
//  Bubble
//
//  Created by steven tran on 5/12/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI

struct UsernameRegistrationView: View {
    @State private var username: String = ""
    @State private var showEmailRegistation = false
    @State private var showingAlert = false
    @State private var activeAlert: StandardAlert = .empty
    var body: some View {
        ZStack{
            NavigationLink(
                "showEmailRegistation", destination: EmailRegistrationView(username: $username),
                isActive: $showEmailRegistation
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
                    Text("Enter in your username").foregroundColor(.white)
                    Spacer()
                    HStack {
                        Image(systemName: "person").foregroundColor(.white)
                        
                        ZStack(alignment: .leading) {
                                if username.isEmpty {
                                    Text("Username")
                                        .foregroundColor(.white)
                                }
                                TextField("", text: $username, onCommit: {
                                    if(username.isEmpty){
                                        self.showingAlert = true
                                        activeAlert = .empty
                                    }
                                    else{
                                        API().checkUsername(username: username)
                                        { (result) in
                                            switch result
                                            {
                                                case .success():
                                                    self.showingAlert = false
                                                    showEmailRegistation = true
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
                                            return Alert(title: Text("Please enter username"),
                                                         message: Text(""),
                                                         dismissButton: .default(Text("OK"), action: {}))
                                        case .duplicate:
                                            return Alert(title: Text("Username already exist"),
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
                    Text("We are an anonymous platform, choose a name will keep you hidden")
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width * 0.8)
                    Spacer()
                    Spacer()
                    Spacer()
                }
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Divider().background(Color(.white))
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
 
extension  UITextField{
    @objc func doneButtonTapped(button:UIBarButtonItem) -> Void {
        print("got here")
       self.resignFirstResponder()
    }

}

struct UsernameRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        UsernameRegistrationView()
    }
}

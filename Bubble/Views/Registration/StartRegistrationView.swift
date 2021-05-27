//
//  StartRegistrationView.swift
//  Bubble
//
//  Created by steven tran on 5/12/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI

struct StartRegistrationView: View {
    var body: some View {
        NavigationView{
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
                        Text("Join Bubble").foregroundColor(.white)
                        Spacer()
                        Text("Creating an account will take a few easy steps")
                            .foregroundColor(.white)
                            .frame(width: UIScreen.main.bounds.width * 0.8)
                        Spacer()
                            NavigationLink(destination: UsernameRegistrationView())
                            {
                                HStack{
                                    Spacer()
                                    Text("Start Registration")
                                        .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                                    Spacer()
                                }
                            }
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.white)
                            .cornerRadius(10)
                            .frame(width: UIScreen.main.bounds.width * 0.8)
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
            }
        }
    }
}

struct StartRegistrationView_Previews: PreviewProvider {
    static var previews: some View {
        StartRegistrationView()
    }
}

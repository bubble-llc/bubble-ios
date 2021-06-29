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
                  .fill(Color("bubble_blue"))
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
                                        .foregroundColor(Color("bubble_blue"))
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
                }
                .navigationBarItems(
                    trailing: Button(action: {
                        UIApplication.shared.windows.first?.rootViewController?.dismiss(animated: true, completion: nil)
                    }, label: {
                        Text("Cancel")
                        .foregroundColor(.white)
                    })
                )
                .navigationBarTitle(Text("Create Account"), displayMode: .inline)
            }
        }
    }
}

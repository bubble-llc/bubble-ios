//
//  MenuView.swift
//  Bubble
//
//  Created by Steven Tran on 12/10/20.
//  Copyright © 2020 Bubble. All rights reserved.
//

import SwiftUI
import SlideOverCard

struct MenuView : View {
    @State private var background = BackgroundStyle.solid
    
    @EnvironmentObject var userAuth: UserAuth

    
    var body : some
    View{
            VStack
            {
                Spacer()
                HStack
                {
                    NavigationLink(destination: UserProfileView())
                    {
                        Image(systemName: "person.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Account").foregroundColor(.white)
                    }
                }.frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height/24.5, alignment: .leading)
                .padding()

                HStack
                {
                    NavigationLink(destination: UserLikedView())
                    {
                        Image(systemName: "checkmark.rectangle.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Liked").foregroundColor(.white)
                    }
                }.frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height/24.5, alignment: .leading)
                .padding()
                    
                HStack
                {
                    NavigationLink(destination: ReportView())
                    {
                        Image(systemName: "envelope.open.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Report").foregroundColor(.white)
                    }
                    
                }.frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height/24.5, alignment: .leading)
                .padding()
                
                HStack
                {
                    Button(action: goExit)
                    {
                        Image(systemName: "paperplane.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Log Out").foregroundColor(.white)
                    }
                    
                }.frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height/24.5, alignment: .leading)
                .padding()
                
                Spacer()
                Spacer()
            }
            .frame(maxWidth: UIScreen.main.bounds.width/2, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .onTapGesture{
                print("nothing")
            }
        
        
    }
    func goProfile() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: UserProfileView())
            window.makeKeyAndVisible()
        }
    }
    func goLiked() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: UserLikedView())
            window.makeKeyAndVisible()
        }
    }
    func goReport() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ReportView())
            window.makeKeyAndVisible()
        }
    }
    func goExit() {
        userAuth.logout()
    }
}


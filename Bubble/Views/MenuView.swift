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
    @Binding var userLatitude: String
    @Binding var userLongitude: String
    
    @State private var background = BackgroundStyle.solid
    
    @EnvironmentObject var userAuth: UserAuth

    var body : some
    View{
            VStack
            {
                HStack
                {
                    NavigationLink(destination: UserProfileView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude))
                    {
                        Image(systemName: "person.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Account").fontWeight(.heavy)
                    }
                    Spacer()
                }

                HStack
                {
                    NavigationLink(destination: UserLikedView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude))
                    {
                        Image(systemName: "checkmark.rectangle.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Liked").fontWeight(.heavy)
                    }
                    Spacer()
                }
                    
                    
                HStack
                {
                    NavigationLink(destination: ReportView())
                    {
                        Image(systemName: "envelope.open.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Report Issue").fontWeight(.heavy)
                    }
                        
                    
                    Spacer()
                }
                    
                HStack
                {
                    Button(action: goExit)
                    {
                        Image(systemName: "paperplane.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Exit").fontWeight(.heavy)
                    }
                    Spacer()
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.black.opacity(0.8))
            .edgesIgnoringSafeArea(.all)
        
    }
    func goProfile() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: UserProfileView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude))
            window.makeKeyAndVisible()
        }
    }
    func goLiked() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: UserLikedView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude))
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

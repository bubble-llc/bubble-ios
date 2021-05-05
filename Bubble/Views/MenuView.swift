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
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var categoryGlobal: Category
    
    var body : some
    View{
        if #available(iOS 14.0, *) {
            VStack
            {
                Group
                {
                    Spacer()
                    HStack
                    {
                        NavigationLink(destination: UserProfileView())
                        {
                            Image("menu_account").resizable().frame(width: 25, height: 25).padding()
                            Text("Account").foregroundColor(.white)
                        }
                    }.frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.005, alignment: .leading)
                    .padding()
                    
                    Divider().frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.height * 0.003).background(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                    
                    HStack
                    {
                        NavigationLink(destination: NotificationView())
                        {
                            Image("menu_account").resizable().frame(width: 25, height: 25).padding()
                            Text("Notifcation").foregroundColor(.white)
                        }
                    }.frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.005, alignment: .leading)
                    .padding()
                    
                    Divider().frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.height * 0.003).background(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                    
                    HStack
                    {
                        NavigationLink(destination: UserLikedView())
                        {
                            Image("menu_likes").resizable().frame(width: 25, height: 25).padding()
                            Text("Liked").foregroundColor(.white)
                        }
                    }.frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.005, alignment: .leading)
                    .padding()
                    
                    Divider().frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.height * 0.003).background(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                }
                
                HStack
                {
                    NavigationLink(destination: FeedbackView().environmentObject(locationViewModel))
                    {
                        Image("menu_report").resizable().frame(width: 25, height: 25).padding()
                        Text("Feedback").foregroundColor(.white)
                    }
                    
                }.frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.005, alignment: .leading)
                .padding()
                
                Divider().frame(width: UIScreen.main.bounds.width * 0.25, height: UIScreen.main.bounds.height * 0.003).background(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                
                HStack
                {
                    Button(action: goExit)
                    {
                        Image("menu_log").resizable().frame(width: 25, height: 25).padding()
                        Text("Log Out").foregroundColor(.white)
                    }
                    
                }.frame(width: UIScreen.main.bounds.width * 0.5, height: UIScreen.main.bounds.height * 0.005, alignment: .leading)
                .padding()
                
                Spacer()
                Spacer()
            }
            .frame(maxWidth: UIScreen.main.bounds.width/2, maxHeight: UIScreen.main.bounds.height, alignment: .topLeading)
            .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .ignoresSafeArea()
            .onTapGesture{
                print("nothing")
            }
        } else {
            // Fallback on earlier versions
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
    func goFeedback() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: FeedbackView().environmentObject(locationViewModel))
            window.makeKeyAndVisible()
        }
    }
    func goExit() {
        userAuth.logout()
        categoryGlobal.fetching = false
        categoryGlobal.posts = [[Post]](repeating: [], count: 5)
    }
}


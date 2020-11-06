//
//  UserLikedView.swift
//  Localist
//
//  Created by Steven Tran on 10/17/20.
//  Copyright © 2020 Localist. All rights reserved.
//

import SwiftUI

struct UserLikedView: View {
    @State private var showSubmitPost: Bool = false
    @State private var showCreateUser: Bool = false
    @State private var post_content: String = ""
    
    @State var size = UIScreen.main.bounds.width / 1.6
    
    @Binding var loggedIn: Bool
    @Binding var userLatitude: String
    @Binding var userLongitude: String
    
    var body: some View {
        ZStack{
            NavigationView {
                PostList(type: "liked", userLatitude: self.$userLatitude , userLongitude: self.$userLongitude, category: self.$userLongitude)
                    .navigationBarTitle(Text("Liked Post"), displayMode: .inline)
                    .navigationBarItems(
                        leading: HStack
                        {
                            Button(action: {self.size = 10}, label: {
                                
                                Image(systemName: "gearshape.fill").resizable().frame(width: 20, height: 20)
                            }).foregroundColor(.black)
                            
                        }
                    )
            }
            
            
            HStack{
                menu(size: $size, loggedIn: self.$loggedIn, userLatitude: self.$userLatitude , userLongitude: self.$userLongitude)
                .cornerRadius(20)
                    .padding(.leading, -size)
                    .offset(x: -size)
                
                Spacer()
            }
            
        }.animation(.spring())
    }
}

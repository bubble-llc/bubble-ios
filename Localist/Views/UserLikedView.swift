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
    
    var body: some View {
        ZStack{
            NavigationView {
                PostList(type: "liked")
                    .navigationBarTitle(Text("Liked Post"), displayMode: .inline)
                    .navigationBarItems(
                        leading: HStack
                        {
                            Button(action: {self.size = 10}, label: {
                                
                                Image(systemName: "gearshape.fill").resizable().frame(width: 20, height: 20)
                            }).foregroundColor(.black)
                            
                            NavigationLink(destination: SubmitPostView(), isActive: $showSubmitPost)
                            {
                                EmptyView()
                            }
                        }
                    )
            }
            
            
            HStack{
                menu(size: $size)
                .cornerRadius(20)
                    .padding(.leading, -size)
                    .offset(x: -size)
                
                Spacer()
            }
            
        }.animation(.spring())
    }
}

struct UserLikedView_Previews: PreviewProvider {
    static var previews: some View {
        UserLikedView()
    }
}

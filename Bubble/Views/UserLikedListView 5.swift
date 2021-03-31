//
//  UserLikedList.swift
//  Bubble
//
//  Created by steven tran on 2/8/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI
import Request

struct UserLikedListView: View {
    @State var posts: [Post] = []
    
    var body: some View
    {
        List(posts){ post in

            PostView(post: post)
        }
        .colorMultiply(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                

        
        .onAppear
        {
            API().getUserLikedPosts
            {
                (posts) in self.posts = posts
            }
        }
        
    }
}


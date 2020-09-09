//
//  SubmitView.swift
//  Localist
//
//  Created by Neil Pasricha on 9/8/20.
//  Copyright © 2020 Localist. All rights reserved.
//

import SwiftUI
import Request

struct SubmitView{
    @State var posts: [Post] = []
    var body: some View {
        List(posts){ post in
             
             NavigationLink(destination: PostDetailView(post: post)) {
                               PostView(post: post)
                           }
        }
    }
}

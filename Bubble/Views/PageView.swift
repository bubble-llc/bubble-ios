//
//  PageView.swift
//  Localist
//
//  Created by Steven Tran on 11/9/20.
//  Copyright © 2020 Localist. All rights reserved.
//

import SwiftUI
import SlideOverCard

struct PageView: View {
    @Binding var userLatitude: String
    @Binding var userLongitude: String
    @State var size = UIScreen.main.bounds.width / 1.6
    
    @State private var position = CardPosition.bottom
    
    @State private var categories = ["Deals", "Happy Hour", "Recreation", "What's Happening?", "Misc"]
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View {
        if #available(iOS 14.0, *) {
            TabView {
                ForEach(0 ..< categories.count) { i in
                    FeedView(userLatitude: self.$userLatitude, userLongitude: self.$userLongitude, category: self.$categories[i])
                        .tabItem {
                            Text(categories[i])
                        }.tag(i)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    .environmentObject(userAuth)
                }
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .tabViewStyle(PageTabViewStyle())
        } else {
            // Fallback on earlier versions
        }
    }
}

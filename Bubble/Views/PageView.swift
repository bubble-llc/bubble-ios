//
//  PageView.swift
//  Localist
//
//  Created by Steven Tran on 11/9/20.
//  Copyright © 2020 Localist. All rights reserved.
//

import SwiftUI
import SlideOverCard
import Combine

struct PageView: View {
    @Binding var userLatitude: String
    @Binding var userLongitude: String
    
    @State private var selectedTab = 0
    
    @State private var categories = ["Deals", "Happy Hour", "Recreation", "What's Happening?", "Misc"]
    @EnvironmentObject var userAuth: UserAuth
    
    @ObservedObject var category = Category()
    
    let minDragTranslationForSwipe: CGFloat = 50
    let numTabs = 5
    
    var body: some View {
        TabView(selection: $selectedTab) {
                ForEach(0 ..< categories.count) { i in
                    FeedView(userLatitude: self.$userLatitude, userLongitude: self.$userLongitude, category: self.$categories[i])
                        .tabItem {
                            Image(systemName: "person.fill").resizable().frame(width: 25, height: 25).padding()
                            Text(categories[i])
                        }.tag(i)
                        .highPriorityGesture(DragGesture().onEnded({ self.handleSwipe(translation: $0.translation.width)}))
                        .animation(.default)
                    .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
                    .environmentObject(userAuth)
                    
                    
                }
            }

    }
    private func handleSwipe(translation: CGFloat) {
        if translation > minDragTranslationForSwipe && selectedTab > 0 {
            selectedTab -= 1
        } else  if translation < -minDragTranslationForSwipe && selectedTab < numTabs-1 {
            selectedTab += 1
        }
    }
}



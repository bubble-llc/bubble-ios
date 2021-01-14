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


@available(iOS 14.0, *)
struct PageView: View {
    @Binding var userLatitude: String
    @Binding var userLongitude: String

    
    @State private var selectedTab = 0
    @State var scale: CGFloat = 1
    @State private var categories = ["Deals", "Happy Hour", "Recreation", "What's Happening?", "Misc"]
    @State private var category_icons = ["price_tag", "beer", "sports", "mega_speaker", "chat_bubble"]
    
    @EnvironmentObject var userAuth: UserAuth
    
    @ObservedObject var category = Category()
    
    @State private var currentPosition: CGSize = .zero
    @State private var newPosition: CGSize = .zero
    
    let minDragTranslationForSwipe: CGFloat = 50
    let numTabs = 5
    @StateObject var tabItems = TabItems()

        var body: some View {
            ZStack {
                ///View1
                FeedView(userLatitude: self.$userLatitude, userLongitude: self.$userLongitude, category: self.$categories[0])
                    .opacity((tabItems.selectedTabIndex == 1) ? 1 : 0)
                ///View2
                FeedView(userLatitude: self.$userLatitude, userLongitude: self.$userLongitude, category: self.$categories[1])
                    .opacity((tabItems.selectedTabIndex == 2) ? 1 : 0)
                FeedView(userLatitude: self.$userLatitude, userLongitude: self.$userLongitude, category: self.$categories[2])
                    .opacity((tabItems.selectedTabIndex == 3) ? 1 : 0)
                FeedView(userLatitude: self.$userLatitude, userLongitude: self.$userLongitude, category: self.$categories[3])
                    .opacity((tabItems.selectedTabIndex == 4) ? 1 : 0)
                FeedView(userLatitude: self.$userLatitude, userLongitude: self.$userLongitude, category: self.$categories[4])
                    .opacity((tabItems.selectedTabIndex == 5) ? 1 : 0)
                TabBar(tabItems: tabItems)
                //                        .gesture(DragGesture()
                //                                                .onEnded({ self.handleSwipe(translation: $0.translation.width)
                //
                //
                //                                                }))
            }
            .animation(.spring())
            .gesture(DragGesture()
                                    .onEnded({ self.handleSwipe(translation: $0.translation.width)


                                    }))
        }

    

    private func handleSwipe(translation: CGFloat) {
        if translation > minDragTranslationForSwipe && tabItems.selectedTabIndex  > 1 {
            
            
            tabItems.selectedTabIndex -= 1
            
        }
            else  if translation < -minDragTranslationForSwipe && tabItems.selectedTabIndex < 5 {
                tabItems.selectedTabIndex += 1
               
                
        }
    }

}
//@available(iOS 14.0, *)
//struct TabBarDemo: View {
//
//}

struct TabBar: View {
    @ObservedObject var tabItems: TabItems
    let padding: CGFloat = 5
    let iconeSize: CGFloat = 20
    var iconFrame: CGFloat {
        (padding * 2) + iconeSize
    }
    var tabItemCount: CGFloat {
        CGFloat(tabItems.items.count)
    }
    var spacing: CGFloat {
        (UIScreen.main.bounds.width - (iconFrame * tabItemCount)) / (tabItemCount + 1)
    }
    var firstCenter: CGFloat {
         spacing + iconFrame/2
    }
    var stepperToNextCenter: CGFloat {
        spacing + iconFrame //half of 1 and half of next
    }
    var body: some View {
        VStack {
            Spacer()
                ZStack {
                    Bar(tabItems: tabItems,
                        firstCenter: firstCenter,
                        stepperToNextCenter: stepperToNextCenter)
                        .foregroundColor(.white)
                        .frame(width: UIScreen.main.bounds.width, height: 50)
                    HStack(spacing: spacing) {
                        ForEach(0..<tabItems.items.count, id: \.self) { i in
                            ZStack {
                                Image(systemName: self.tabItems.items[i].imageName)
                                    .resizable()
                                    .foregroundColor(Color.gray)
                                    .frame(width: self.iconeSize, height: self.iconeSize)
                                    .opacity(self.tabItems.items[i].opacity)
                                    .padding(.all, padding)
                                    .background(Color.white)
                                    .clipShape(Circle())
                                    .onTapGesture {
                                        withAnimation(Animation.easeInOut) {
                                            self.tabItems.select(i)
                                        }
                                    }
                                
                            }
                            .offset(y: self.tabItems.items[i].offset)
                        }
            }
                    
            .edgesIgnoringSafeArea(.all)
           }
        }
    }
}


struct Bar: Shape {
    @ObservedObject var tabItems: TabItems
    var tab: CGFloat
    let firstCenter: CGFloat
    let stepperToNextCenter: CGFloat
    
    init(tabItems: TabItems, firstCenter: CGFloat, stepperToNextCenter: CGFloat) {
        self.tabItems = tabItems
        self.tab = tabItems.selectedTabIndex
        self.firstCenter = firstCenter
        self.stepperToNextCenter = stepperToNextCenter
    }
    
    var animatableData: Double {
        get { return Double(tab) }
        set { tab = CGFloat(newValue) }
    }
    
    func path(in rect: CGRect) -> Path {
        let tabCenter = firstCenter + stepperToNextCenter * (tab - 1)
        return Path { p in
            p.move(to: CGPoint(x: rect.minX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.minY))
            p.addLine(to: CGPoint(x: tabCenter + 50, y: rect.minY))
            p.addCurve(to: CGPoint(x: tabCenter, y: rect.midY),
                          control1: CGPoint(x: tabCenter + 20, y: rect.minY),
                          control2: CGPoint(x: tabCenter + 20, y: rect.minY + 25))
            p.addCurve(to: CGPoint(x: tabCenter - 50, y: rect.minY),
                          control1: CGPoint(x: tabCenter - 20, y: rect.minY + 25),
                          control2: CGPoint(x: tabCenter - 20, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.maxX - tabCenter, y: rect.minY))
        }
    }
}

class TabItem: Identifiable {
    let id = UUID()
    let imageName: String
    var offset: CGFloat = -5
    var opacity: Double = 1
    
    init(imageName: String, offset: CGFloat) {
        self.imageName = imageName
        self.offset = offset
    }
    init(imageName: String) {
        self.imageName = imageName
    }
}

class TabItems: ObservableObject {

    @Published var items: [TabItem] = [
        TabItem(imageName: "sports", offset: -10),
        TabItem(imageName: "magnifyingglass"),
        TabItem(imageName: "plus.app"),
        TabItem(imageName: "heart"),
        TabItem(imageName: "person"),
    ]
    
    @Published var selectedTabIndex: CGFloat = 1
    
    func select(_ index: Int) {
        let tabItem = items[index]
        
        tabItem.opacity = 0
//        tabItem.offset = 15
        
        withAnimation(Animation.easeInOut) {
            selectedTabIndex = CGFloat(index + 1)
//            for i in 0..<items.count {
//                if i != index {
//                    items[i].offset = -5
//                }
//            }
        }
        withAnimation(Animation.easeIn(duration: 0.25).delay(0.25)) {
            tabItem.opacity = 1
            
//            tabItem.offset = -25
        }
    }
}



////
/////  PageView.swift
////  Localist
////
////  Created by Steven Tran on 11/9/20.
////  Copyright © 2020 Localist. All rights reserved.
////
//
//import SwiftUI
//import SlideOverCard
//import Combine
//
//
//@available(iOS 14.0, *)
//struct PageView: View {
//    @Binding var userLatitude: String
//    @Binding var userLongitude: String
//
//
//    @State private var selectedTab = 0
//    @State var scale: CGFloat = 1
//    @State private var categories = ["Deals", "Happy Hour", "Recreation", "What's Happening?", "Misc"]
//    @State private var category_icons = ["price_tag", "beer", "sports", "mega_speaker", "chat_bubble"]
//
//    @EnvironmentObject var userAuth: UserAuth
//
//    @ObservedObject var category = Category()
//
//    @State private var currentPosition: CGSize = .zero
//    @State private var newPosition: CGSize = .zero
//
//    let minDragTranslationForSwipe: CGFloat = 50
//    let numTabs = 5
//
//    var body: some View {
//
//        if #available(iOS 14.0, *) {
//
//            TabView(selection: $selectedTab)
//            {
//
//                ForEach(0 ..< categories.count) { i in
//
//                    FeedView(userLatitude: self.$userLatitude, userLongitude: self.$userLongitude, category: self.$categories[i])
//                        .tabItem
//                        {
//                            GeometryReader { geometry in
//                                Image(category_icons[i])
//                                    .resizable()
//                                    .aspectRatio(contentMode: .fit)
//                                    .frame(width: geometry.size.width/5, height: geometry.size.height/28)
//                                    .padding(.top, 10)
//                            }
//                            Text(categories[i])
//                        }.tag(i)
//                        .gesture(DragGesture()
//                                                .onEnded({ self.handleSwipe(translation: $0.translation.width)
//
//
//                                                }))
//
//                        .clipShape(RoundedRectangle(cornerRadius: 10.0, style: .continuous))
//                        .environmentObject(userAuth)
//
//
//
//                }
//            }
//        } else {
//            // Fallback on earlier versions
//        }
//
//    }
//    private func handleSwipe(translation: CGFloat) {
//        if translation > minDragTranslationForSwipe && selectedTab > 0 {
//
//
//            selectedTab -= 1
//
//        }
//            else  if translation < -minDragTranslationForSwipe && selectedTab < numTabs-1 {
//                selectedTab += 1
//
//
//        }
//    }
//}
//
//

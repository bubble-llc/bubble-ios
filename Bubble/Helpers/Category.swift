//
//  category.swift
//  Bubble
//
//  Created by Neil Pasricha on 12/28/20.
//  Copyright © 2020 Bubble. All rights reserved.
//

import Foundation
import Combine

class Category: ObservableObject {
    var fetching:Bool {
        willSet {
            objectWillChange.send()
        }
    }
    let objectWillChange = ObservableObjectPublisher()
    
    let cat_icons = ["dealsf1", "hhf1", "recf1", "whf1", "miscf1"]
    let categories = ["Deals", "Happy Hour", "Recreation", "What's Happening?", "Misc"]
    let categoriesMap = ["Deals":1, "Happy Hour":2, "Recreation":3, "What's Happening?":4, "Misc":5]
    let cat_names1 = ["deals1", "hh1", "rec1", "wh1", "misc1"]
    let selected_cat_names1 = ["dealsf1", "hhf1", "recf1", "whf1", "miscf1"]
    
    var posts = [[Post]](repeating: [], count: 5)
    var category_id:Int
    var currCategory:String {
        willSet {
            objectWillChange.send()
        }
    }
    let userLongitude = "50.2"
    let userLatitude = "1.0"
    
    init() {
        self.currCategory = "Bubble"
        self.category_id = 1
        self.fetching = false
    }
    
    func setCategory(category: String) {
        self.currCategory = category
        self.category_id = categoriesMap[category]!
        print(self.currCategory)
    }
    
    func fetchData() {
        let group = DispatchGroup()
        for category in self.categories{
            group.enter()
            API().getPosts(logitude: self.userLongitude, latitude: self.userLatitude, category: category)
            {
                (posts) in self.posts[self.categoriesMap[category]! - 1] = posts
                group.leave()
            }
        }
        group.notify(queue: .main, execute: {
            print(self.posts[0])
            self.fetching = true
        })
    }
    
    func refreshCategory(category: String) {
        self.fetching = true
        API().getPosts(logitude: self.userLongitude, latitude: self.userLatitude, category: category)
        {
            
            
            (posts) in self.posts[self.categoriesMap[category]! - 1] = posts
            print(self.posts[self.categoriesMap[category]! - 1])
            self.fetching = true
        }
        
    }
}


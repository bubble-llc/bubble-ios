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
    let objectWillChange = ObservableObjectPublisher()
    
    var currCategory:String {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        self.currCategory = "Bubble"
    }
    
    func setCategory(category: String) {
        self.currCategory = category
        print(self.currCategory)
    }
}


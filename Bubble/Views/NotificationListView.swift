//
//  NotificationListView.swift
//  Bubble
//
//  Created by steven tran on 5/5/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI
import Request


struct NotificationListView: View {
    @State var notifications: [Notification] = []
    
    var body: some View {
        List(notifications){ notification in
//            PostView(post: notifications)
        }
        .colorMultiply(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
        .onAppear
        {
            API().getNotificaiton()
            { (result) in
                switch result
                {
                    case .success(let notifications):
                        self.notifications = notifications
                    case .failure(let error):
                        print(error)
                }
            }
        }

    }
}

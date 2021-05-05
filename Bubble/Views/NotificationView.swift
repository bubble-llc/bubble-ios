//
//  NotificationView.swift
//  Bubble
//
//  Created by steven tran on 5/5/21.
//  Copyright © 2021 Bubble. All rights reserved.
//

import SwiftUI

struct NotificationView: View {
    var body: some View {
        ZStack(alignment: .top){
            NotificationListView()
                .navigationBarTitle(Text("Notifications"), displayMode: .inline)
        }.padding(.top)
        .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
        .edgesIgnoringSafeArea(.bottom)

    }
}

struct NotificationView_Previews: PreviewProvider {
    static var previews: some View {
        NotificationView()
    }
}


//
//  UserLikedView.swift
//  Localist
//
//  Created by Steven Tran on 10/17/20.
//  Copyright © 2020 Localist. All rights reserved.
//

import SwiftUI

struct UserLikedView: View {
    @State private var sortBy: SortBy = .hot
    @State private var showSortSheet: Bool = false
    @State private var showSubmitPost: Bool = false
    @State private var showCreateUser: Bool = false
    @State private var post_content: String = ""
    
    @State var size = UIScreen.main.bounds.width / 1.6
    
    var body: some View {
        ZStack{
            NavigationView {
                PostList()
                    .navigationBarTitle(Text("Feed"), displayMode: .inline)
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
                        },
                        trailing: HStack
                        {
                            Button(action: {self.showSortSheet.toggle()})
                            {
                                HStack
                                {
                                    Image(systemName: "arrow.up.arrow.down")
                                    Text(self.sortBy.rawValue)
                                }
                            }
                        }
                    )
                    .actionSheet(isPresented: $showSortSheet)
                    {
                        ActionSheet(title: Text("Sort By:"), buttons: [SortBy.hot,SortBy.new, ].map
                            { method in
                                ActionSheet.Button.default(Text(method.rawValue.prefix(1).uppercased() + method.rawValue.dropFirst()))
                                {
                                    self.sortBy = method
                                }
                            }
                        )
                    }
                Text("Select a post")
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

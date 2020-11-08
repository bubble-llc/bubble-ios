import SwiftUI
import Request

struct PostList: View {
    @State var posts: [Post] = []
    
    let type: String
    @Binding var userLatitude: String
    @Binding var userLongitude: String
    @Binding var category: String
    
    @State private var categories = ["Deals", "Happy Hour", "Recreation", "What's Happening?", "Misc"]
    
    var body: some View
    {
        if categories.contains(category)
        {
            Spacer()
            Text(category)
        }
        List(posts){ post in
            PostView(post: post)
        }.onAppear
        {
            if(type == "feed"){
                var formatted_category = ""
                if category == "Happy Hour"
                {
                    formatted_category = "Happy_Hour"
                }
                else if category == "What's Happening?"
                {
                    formatted_category = "What's_Happening?"
                }
                else
                {
                    formatted_category = category
                }
                API().getPosts(logitude: userLongitude, latitude: userLatitude, category: formatted_category)
                {
                    (posts) in self.posts = posts
                }
             }
             else if(type == "liked"){
                 API().getUserLikedPosts
                 {
                     (posts) in self.posts = posts
                 }
             }
}
    }
}


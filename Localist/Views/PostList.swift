import SwiftUI
import Request

struct PostList: View {
    @State var posts: [Post] = []
    
    let type: String
    @Binding var userLatitude: String
    @Binding var userLongitude: String
    
    var body: some View
    {
        List(posts){ post in
            PostView(post: post)
        }.onAppear
        {
            if(type == "feed"){
                 API().getPosts(logitude: userLongitude, latitude: userLatitude)
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


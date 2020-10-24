import SwiftUI
import Request

struct PostList: View {
    @State var posts: [Post] = []
    
    let type: String
    
    var body: some View
    {
        List(posts){ post in
             NavigationLink(destination: PostDetailView(post: post))
             {
                PostView(post: post)
             }
        }.onAppear
        {
            if(type == "feed"){
                 API().getPosts
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


import SwiftUI
import Request

struct PostList: View {
    @State var posts: [Post] = []
    
    var body: some View
    {
        List(posts){ post in
             NavigationLink(destination: PostDetailView(post: post))
             {
                PostView(post: post)
             }
        }.onAppear
        {
            API().getPosts
            {
                (posts) in self.posts = posts
            }
        }
    }
}


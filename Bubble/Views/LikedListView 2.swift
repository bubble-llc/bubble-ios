import SwiftUI
import Request

struct LikedListView: View {
    @State var posts: [Post] = []
    
    var body: some View
    {
        List(posts){ post in

            PostView(post: post)
        }
        .colorMultiply(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
        .onAppear
        {
            API().getUserLikedPosts
            {
                (posts) in self.posts = posts
                print(self.posts.count)
            }
        }
        
    }
}

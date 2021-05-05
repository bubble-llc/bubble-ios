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
            { (result) in
                switch result
                {
                    case .success(let posts):
                        self.posts = posts
                    case .failure(let error):
                        print(error)
                }
            }
        }
        
    }
}

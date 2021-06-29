import SwiftUI
import Request

struct LikedListView: View {
    @State var posts: [Post] = []
    
    var body: some View
    {

        List{
            ForEach(posts){ post in
                PostView(post:post)
                .listRowBackground(Color("bubble_blue"))
            }
        }
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

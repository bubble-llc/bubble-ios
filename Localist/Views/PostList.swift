import SwiftUI
import Request

struct PostList: View {
    @State var posts: [Post] = []
    var body: some View {
        
            
            
                
            
        List(posts){ post in
             
             NavigationLink(destination: PostDetailView(post: post)) {
                               PostView(post: post)
                           }

        }.onAppear{
                API().getPosts { (posts) in
                    self.posts = posts
                }
        /// Load posts from web and decode as `Listing`
//        RequestView(Listing.self, Request {
//            Url(API.title(id, sortBy))
//            Query([])
//        }) { listing in
//            /// List of `PostView`s when loaded
//            List(listing != nil ? listing!.data.children.map { $0.data } : []) { post in
//                NavigationLink(destination: PostDetailView(post: post)) {
//                    PostView(post: post)
                }
            }
    
    
            /// Spinner when loading
}


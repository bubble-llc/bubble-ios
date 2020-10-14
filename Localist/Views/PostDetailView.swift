import SwiftUI
import Request

struct PostDetailView: View {
    let post: Post
    @State var comments: [Comment] = []
    var body: some View {
        NavigationView {
            VStack
            {
                Text(post.title)
                    .bold()
                if post.content != "" {
                    Text(post.content)
                }

                MetadataView(post: post, spaced: true)
                
                List(comments){ comment in
                    CommentsView(comment: comment)

                }
                .onAppear{
                    API().getComment(post_id: post.id) { (comments) in
                        self.comments = comments
                    }
                }
            }
        }
    }
}

//#if DEBUG
//struct PostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailView(post: Post.title)
//    }
//}
//#endif

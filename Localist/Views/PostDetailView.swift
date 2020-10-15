import SwiftUI
import Request

struct PostDetailView: View {
    let post: Post
    @State var comments: [Comment] = []
    var body: some View {
        NavigationView {
            VStack
            {
                //Post title. The Frame indicatew where it will be aligned, font adjusts text size
                Text(post.title)
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.system(size:30))
                //Built in function for adding spaces in V/H Stacks
                Divider()
                
                //If it IS empty it should not be valid in the first place. Need to figure out how to rework this
                if post.content != "" {
                    Text(post.content)
                }
                
                Divider()
                
                //Removed spacing from MetadataView in this context to keep it centered rather than offset on the right side.
                MetadataView(post: post, spaced: false)
                
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

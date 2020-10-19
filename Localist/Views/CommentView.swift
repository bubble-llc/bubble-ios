import SwiftUI
import Request

struct CommentView: View {
    let post: Post
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {

                Text(post.title)
                    .font(.headline)
                    .lineLimit(1)

                /// Body preview
                Group {
                        Text(post.content)
                
                    
                }
                MetadataView(post: post)
                    .font(.caption)
            }
        }
    }
}

//#if DEBUG
//struct PostView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostView(post: Post.title)
//    }
//}
//#endif

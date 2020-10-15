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

                MetadataView(post: post)
                
                List(comments){ comment in
                    CommentsView(comment: comment)

                }
                .onAppear{
                    API().getComment(post_id: post.id) { (comments) in
                        self.comments = comments
                    }
                }
                FooterView(post: post)
            }
        }
    }
}

struct FooterView: View {
    @State private var comment_content: String = ""
    @State private var placeholderString: String = "Add a comment"
    
    let post: Post
    
    var body: some View {
        MultilineTextField("Enter comment here...", text: self.$comment_content)
            .frame(maxWidth: .infinity, minHeight: 100)
        Button(action:
        {
            let defaults = UserDefaults.standard
            let username = defaults.string(forKey: defaultsKeys.keyOne)!
            let commentObject: [String: Any]  =
                [
                    "post_id": post.id,
                    "username": username,
                    "content": self.comment_content,
                ]
            API().submitComment(submitted: commentObject)
            self.comment_content = ""
        })
        {
            Text("Submit")
        }
    }
}

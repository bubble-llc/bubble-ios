import SwiftUI
import Request

struct PostDetailView: View {
    let post: Post
    
    @Binding var isUp: Bool
    @Binding var isDown: Bool
    @Binding var totalVotes: Int
    @Binding var upColor: Color
    @Binding var downColor: Color
    @Binding var isVoted: Bool
    
    @State var comments: [Comment] = []
    
    var body: some View {
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
                MetadataView(post: post,
                             isUp: self.$isUp,
                             isDown: self.$isDown,
                             totalVotes: self.$totalVotes,
                             upColor: self.$upColor,
                             downColor: self.$downColor,
                             isVoted: self.$isVoted)
                
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
            let username = defaults.string(forKey: defaultsKeys.username)!
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

import SwiftUI
import Request

struct SubmitCommentView: View {
    @State private var post_title: String = ""
    @State private var post_content: String = ""
    @State private var comment_content: String = ""
    @State private var submitButtonPressed: Bool = false
    
    let post: Post
    
    
    var body: some View
    {
        if submitButtonPressed
        {
            FeedView()
        }
        else
        {
            Form {
                Text(post.title).font(.headline)
                    .foregroundColor(Color.blue)
                Text(post.content)
                if #available(iOS 14.0, *)
                {
                    TextEditor(text: self.$comment_content)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                        .border(Color.black, width:1)
                        .foregroundColor(Color.blue)
                    
                }
                else
                {
                    MultilineTextField("Enter comment here...", text: self.$comment_content)
                        .padding(3)
                        .frame(minWidth: 100, idealWidth: 100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center)
                        .background(RoundedRectangle(cornerRadius:5))
                }
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
                    self.submitButtonPressed=true
                    
                })
                {
                    Text("Submit")
                }
            }
            .foregroundColor(Color.blue)
            .background(Color.yellow)
        }
    }
}

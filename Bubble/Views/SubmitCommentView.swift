import SwiftUI
import Request

struct SubmitCommentView: View {
    @State private var post_title: String = ""
    @State private var post_content: String = ""
    @State private var comment_content: String = "Enter your comment here"
    @State private var commentBoxPressed: Bool = false
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    let post: Post
    
    
    var body: some View
    {


            Form {
                    Text(post.title).font(.system(size:25))
                    .foregroundColor(Color.black)
                    .italic()
                    .bold()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
                
                Text(post.content)
                    .foregroundColor(Color.black)
                    .italic()
                    .frame(maxWidth: .infinity, alignment: .center)
                    .listRowBackground(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
                if #available(iOS 14.0, *)
                {
                    //We are currently allowing there to be trailing spaces after comments, need to auto remove those from the comment
                    //object before we actually let it be submitted
                    TextEditor(text: self.$comment_content)
                        .onTapGesture {
                            if !self.commentBoxPressed{
                                self.comment_content = " "
                                self.commentBoxPressed = true
                            }
                        }
                        .multilineTextAlignment(.leading)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 200)
                        .background(Color.white)
                        .cornerRadius(25)
                        .foregroundColor(commentBoxPressed ? Color.black : Color.gray)
                        .listRowBackground(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
                    
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
                    let commentObject: [String: Any]  =
                        [
                            "post_id": post.id,
                            "content": self.comment_content,
                        ]
                    API().submitComment(submitted: commentObject)
                    self.presentationMode.wrappedValue.dismiss()
                    
                })
                {
                    Text("Submit")                        .fontWeight(.bold)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                    
                }
                .buttonStyle(PlainButtonStyle())
                .listRowBackground(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
            }
            .foregroundColor(Color.blue)
        
    }
}

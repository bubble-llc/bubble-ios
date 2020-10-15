import SwiftUI
import Request

struct SubmitPostView: View {
    @State private var post_title: String = "Enter your title"
    @State private var post_title_pressed: Bool = false
    @State private var post_content: String = "Write some content for your post"
    @State private var post_content_pressed: Bool = false
    @State private var submitButtonPressed: Bool = false
    
    var body: some View
    {
        if submitButtonPressed
        {
            FeedView()
        }
        else
        {
            Form {
                Text("What's Happening?")
                    .foregroundColor(Color.black)
                    .font(.system(size:35))
                    .frame(maxWidth: .infinity, alignment: .center)
                if #available(iOS 14.0, *)
                {
                    Text("Title").font(.headline)
                        .foregroundColor(Color.blue)
                    TextEditor(text: self.$post_title)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 40, maxHeight: 75)
                        .border(Color.black, width:1)
                        .foregroundColor(post_title_pressed ? Color.black : Color.gray)
                        .multilineTextAlignment(.leading)
                        .onTapGesture {
                            if !self.post_title_pressed{
                                self.post_title = " "
                                self.post_title_pressed = true
                            }
                               
                        }
                    
                    
                    Text("Content").font(.headline)
                        .foregroundColor(Color.blue)
                    TextEditor(text: self.$post_content)
                        .padding()
                        .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 350)
                        .border(Color.black, width:1)
                        .foregroundColor(post_content_pressed ? Color.black : Color.gray)
                        .multilineTextAlignment(.leading)
                        .onTapGesture {
                            if !self.post_content_pressed{
                                self.post_content = " "
                                self.post_content_pressed = true
                            }
                               
                        }
                }
                else
                {
                    MultilineTextField("Enter post here...", text: self.$post_content)
                        .padding(3)
                        .frame(minWidth: 100, idealWidth: 100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center)
                        .background(RoundedRectangle(cornerRadius:5))
                }
                Button(action:
                {
                    let defaults = UserDefaults.standard
                    let username = defaults.string(forKey: defaultsKeys.keyOne)!
                    let postObject: [String: Any]  =
                    [
                        "username": username,
                        "category_name": "What's happening?",
                        "content": self.post_content,
                        "title": self.post_title,
                        "zipcode": "78703"
                    ]
                    API().submitPost(submitted: postObject)
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

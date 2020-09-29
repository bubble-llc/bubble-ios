import SwiftUI
import Request

struct SubmitPostView: View {
    @State private var post_title: String = ""
    @State private var post_content: String = ""
    @State private var submitButtonPressed: Bool = false
    
    
    var body: some View{
    
      
                if submitButtonPressed {
                    FeedView()
                }
                else {
                    
            
                    
    
        
    Form {
        
        Text("What's going on?")
        if #available(iOS 14.0, *)
        {
            
            Text("Title").font(.headline)
                .foregroundColor(Color.blue)
                
            TextEditor(text: self.$post_title)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 50)
                .border(Color.black, width:1)
                .foregroundColor(Color.blue)
            
            Text("Content").font(.headline)
                .foregroundColor(Color.blue)
            TextEditor(text: self.$post_content)
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 500)
                .border(Color.black, width:1)
                .foregroundColor(Color.blue)
            
        }
        else
        {
            // Fallback on earlier versions
            MultilineTextField("Enter post here...", text: self.$post_content)
                .padding(3)
                .frame(minWidth: 100, idealWidth: 100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center)
                .background(RoundedRectangle(cornerRadius:5))
        }
        
        Button(action: {
            //                        self.post_content = "nice"
            let postObject: [String: Any]  =
                [
                    "username": "steventt07",
                    "category_name": "What's happening?",
                    "content": self.post_content,
                    "title": self.post_title,
                    "zipcode": "78703"
                ]
            API().submitPost(submitted: postObject)
            self.submitButtonPressed=true
            
        })
        {
            //This is where the submit button logic will go
            Text("Submit")
        }
    }.foregroundColor(Color.blue)
    .background(Color.yellow)
    }
    }
}

import SwiftUI

struct MetadataView: View {
    @State private var showCommentForm: Bool = false
    
    @State var upvotes:Int = 0
    @State var downvotes:Int = 0
    @State var upvoteClicked = false
    @State var downvoteClicked = false
    @State var local_votes:Int = 0
    @State var posts: [Post] = []
    @State var comments: [Comment] = []
    
    let post: Post
    let spaced: Bool
    
    var body: some View {
        /// Spacers are placed to fill the width of the screen if desired
        HStack
        {
            
            if spaced
            {
                Spacer()
            }
            
            //Upvote button
            Button(action:  {
                if self.spaced
                {
                    Spacer()
                }
                
                if self.local_votes == 0 && self.downvotes > 0
                {
                    self.local_votes = 1
                    self.upvotes += 1
                    self.downvotes -= 1
                    
                }
                else if self.downvotes == 0 && self.local_votes == 0
                {
                    self.local_votes = 1
                    self.upvotes += 1
                }
                else if self.downvotes < 0 && self.local_votes == 0
                {
                    self.local_votes = 1
                    self.upvotes += 1
                    self.downvotes += 1
                }
                else if self.upvotes > 0 && self.local_votes == 1
                {
                    self.local_votes = 0
                    self.upvotes -= 1
                }
            })
            {
                Image(systemName: "arrow.up")
                Text(String(self.upvotes))
            }.foregroundColor(Color.blue).buttonStyle(BorderlessButtonStyle())
            
            //Downvote button
            Button(action:  {
                    if self.spaced
                    {
                        Spacer()
                    }
                
                    if self.local_votes == 1 && self.upvotes > 0
                    {
                        self.local_votes = 0
                        self.upvotes -= 1
                        self.downvotes -= 1
                        
                    }
                    else if self.upvotes == 0 && self.local_votes == 1
                    {
                        self.local_votes = 0
                        self.downvotes -= 1
                    }
                    else if self.upvotes == 0 && self.local_votes == 0
                    {
                        if self.downvotes < 0
                        {
                            self.downvotes += 1
                        }
                        else
                        {
                            self.downvotes -= 1
                        }
                    }
            })
            {
                Image(systemName: "arrow.down")
                Text(String(self.downvotes))
            }.foregroundColor(Color.red).buttonStyle(BorderlessButtonStyle())
            Button(action: {self.showCommentForm.toggle()})
            {
                Image(systemName: "text.bubble")
                Text(String(post.comments))
            }.foregroundColor(Color.primary).buttonStyle(BorderlessButtonStyle())
            
            NavigationLink(destination: SubmitCommentView(post: post), isActive:$showCommentForm)
            {
                EmptyView()
            }
        }
    }
}

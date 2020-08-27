import SwiftUI

struct MetadataView: View {
    let post: Post
    let spaced: Bool
    @State var upvotes:Int = 0
    @State var downvotes:Int = 0
    @State var upvoteClicked = false
    @State var downvoteClicked = false
    @State var local_votes:Int = 0
    @State var posts: [Post] = []
    
    var body: some View {
        /// Spacers are placed to fill the width of the screen if desired
        HStack {
            if spaced {
                Spacer()
            }
//            Button(action: {}){
//                Image("arrow.up")
//                Text("12")
//                Color("blue")
//            }.foregroundColor(Color.primary)
            
            //Upvote button
            Button(action:  {
                
                    if self.spaced {
                        Spacer()
                    }
                if self.local_votes==0&&self.downvotes>0{
                    self.local_votes=1
                    self.upvotes+=1
                    self.downvotes-=1
                    
                }
                else if self.downvotes==0&&self.local_votes==0{
                    self.local_votes=1
                    self.upvotes+=1
                }
                else if self.downvotes<0&&self.local_votes==0{
                    self.local_votes=1
                    self.upvotes+=1
                    self.downvotes+=1
                }
                else if self.upvotes>0&&self.local_votes==1{
                    self.upvotes-=1
                    self.local_votes=0
                }
//                if !self.upvoteClicked&&self.downvoteClicked{
//
//                    self.upvotes+=1
//                    self.downvotes+=1
//                }
//
//                else if self.upvoteClicked&&self.downvoteClicked{
//                    self.upvotes+=1
//                    self.downvotes+=1
//                }
//
//               else if !self.upvoteClicked{
//                    self.upvotes+=1
//                    self.upvoteClicked=true
//                }
                
             
            }){
                Image(systemName: "arrow.up")
                Text(String(self.upvotes))
            }.foregroundColor(Color.blue).buttonStyle(BorderlessButtonStyle())
            
            //Downvote button
            Button(action:  {
            
                    if self.spaced {
                        Spacer()
                    }
                
        if self.local_votes==1&&self.upvotes>0{
            self.local_votes=0
            self.upvotes-=1
            self.downvotes-=1
            
        }
        else if self.upvotes==0&&self.local_votes==1{
            self.local_votes=0
            self.downvotes-=1
        }
        else if self.upvotes==0&&self.local_votes==0{
            if self.downvotes<0{
                self.downvotes+=1
            }
            else{
            self.downvotes-=1
            }
                }

//                if self.upvotes==0{
//                    self.local_votes=0
//                    self.downvotes-=1
//                }
//                else if self.local_votes==0{
//                    self.local_votes=0
//                    self.upvotes-=1
//                    self.downvotes-=1
//                }
//                if !self.downvoteClicked&&self.upvoteClicked{
//                    self.downvotes+=1
//                    self.upvotes-=1
//                    self.downvoteClicked=true
//                }
//                else if self.downvoteClicked&&self.upvoteClicked{
//                    self.downvotes-=1
//                    self.upvotes+=1
//                    self.downvoteClicked=true
//                }
//                else if !self.downvoteClicked{
//                    self.downvotes-=1
//                    self.downvoteClicked=true
//                }
                
             
            }){
                Image(systemName: "arrow.down")
                Text(String(self.downvotes))
            }.foregroundColor(Color.red).buttonStyle(BorderlessButtonStyle())
            
            //Number of comments
            Button(action:  {
                List(self.posts){ post in
                         NavigationLink(destination: PostDetailView(post: post)) {
                                           PostView(post: post)
                                       }

                    }.onAppear{
                            API().getPosts { (posts) in
                                self.posts = posts
                            }
             
                }}){
                Image(systemName: "text.bubble")
                Text("14")
            }.foregroundColor(Color.primary).buttonStyle(BorderlessButtonStyle())
//            ForEach([("arrow.up", String(self.upvotes), Color.blue),("arrow.down", downvotes, Color.red),("text.bubble", "\(13)", Color.primary)], id: \.0) { data in
//                Button(action:  {
//                        if self.spaced {
//                            Spacer()
//                        }
//                    self.upvotes=self.upvotes+1
//
//                }){
//                    Image(systemName: data.0)
//                    Text(data.1)
//                }.foregroundColor(data.2)
//
//            }
        }
    }
}

//#if DEBUG
//struct MetadataView_Previews: PreviewProvider {
//    static var previews: some View {
//        MetadataView(post: Post.title, spaced: true)
//    }
//}
//#endif

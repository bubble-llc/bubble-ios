import SwiftUI
import Request

struct PostView: View
{
    let post: Post
    
    @State var isUp = false
    @State var isDown = false
    @State var totalVotes:Int = 0
    @State var upColor = Color.gray
    @State var downColor = Color.gray
    @State var isVoted = false
    
    init(post: Post) {
        self.post = post
        self._totalVotes = State(initialValue: post.votes)
        
        
        if post.is_voted == true
        {
            self._isVoted = State(initialValue: true)
            if post.prev_vote == 1
            {
                self._isUp = State(initialValue: true)
                self._upColor = State(initialValue: Color.green)
            }
            else if post.prev_vote == -1
            {
                self._isDown = State(initialValue: true)
                self._downColor = State(initialValue: Color.red)
            }
        }
    }
    
    var body: some View
    {
        
        NavigationLink(destination: PostDetailView( post: post,
                                                    isUp: self.$isUp,
                                                    isDown: self.$isDown,
                                                    totalVotes: self.$totalVotes,
                                                    upColor: self.$upColor,
                                                    downColor: self.$downColor,
                                                    isVoted: self.$isVoted)
            )
        
        {
            VStack(alignment: .leading)
            {
                HStack{
                    Text(post.username)
                        .offset(x:5)
                        .colorInvert()
                        .foregroundColor(Color.gray)
                    Spacer()
                    Text(post.title)
                        .font(.headline)
                        .offset(x:5)
                        .lineLimit(1)
                        .colorInvert()
                        .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                    Spacer()
                    Spacer()
                }
                Group
                {
                    Text(post.content)
                        .offset(x:5)
                        .colorInvert()
                        .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                }
                //This is where we show the metadata at the bottom of each post in the feedView
                //Removing this would show posts without any votes/comments
                
           
                
                MetadataView(post: post,
                             isUp: self.$isUp,
                             isDown: self.$isDown,
                             totalVotes: self.$totalVotes,
                             upColor: self.$upColor,
                             downColor: self.$downColor,
                             isVoted: self.$isVoted)
                    .font(.caption)
                    .offset(x:5)
                        .colorInvert()
                        .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                
            }
            
        }
        .frame(width: UIScreen.main.bounds.width-40, height: UIScreen.main.bounds.height/10, alignment: .center)
        .background(Color.black)
        .listRowBackground(Color.black)
        .colorInvert()
        .cornerRadius(20)
        .border(Color.white, width: 2)
        
    }
    
}

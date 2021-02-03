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
    
    @State private var showCommentForm: Bool = false
    @State var comments: [Comment] = []
    @State var globalDirection:Int = 0
    @State var direction:Int = 0
    @State private var downvote = false
    @State private var upVote = false
    
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
            VStack(alignment: .leading, spacing: 0){
                Spacer()
                HStack{
                    Text(post.username)
                        .colorInvert()
                        .foregroundColor(Color.gray)
                        .font(.system(size: 12))
                        .padding(.leading)
                    Spacer()
                                        
                    Text(post.title)
                        .font(.headline)
                        .lineLimit(1)
                        .colorInvert()
                        .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                    Spacer()
                    //upVote
                    Button(action:
                    {
                        if self.isUp == false && self.isDown == false
                        {
                            self.totalVotes += 1
                            self.globalDirection = 1
                            self.isUp = true
                            self.upColor = Color.green
                            self.direction = 1
                        }
                        else if self.isUp == false && self.isDown == true
                        {
                            self.totalVotes += 1
                            self.globalDirection = 1
                            self.isDown = false
                            self.downColor = Color.gray
                        }
                        else if self.isUp == true
                        {
                            self.totalVotes -= 1
                            self.globalDirection = -1
                            self.isUp = false
                            self.upColor = Color.gray
                        }
                        
                        let defaults = UserDefaults.standard
                        let username = defaults.string(forKey: defaultsKeys.username)!
                        let voteObject: [String: Any]  =
                        [
                            "username": username,
                            "post_id": self.post.id,
                            "direction": self.direction,
                            "is_voted": self.isVoted,
                            "global_direction": self.globalDirection
                        ]
                        
                        self.isVoted = true
                        
                        API().submitVote(submitted: voteObject)
                    })
                    {
                        Image(systemName: self.isUp == true ? "arrowtriangle.up.fill" : "arrowtriangle.up" )
                            .resizable()
                            .frame(width:18,height:18)
                            
                    }
                    
                    .colorInvert()
                    .foregroundColor(self.upColor).buttonStyle(BorderlessButtonStyle())
                    .padding(.trailing)
                }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height/45)
                
                HStack{
                    
                    Image(systemName: "01.circle.fill")
                        .resizable()
                        .colorInvert()
                        .frame(width:30, height:30)
                        .padding(.leading, 17)
                    

                    Text(post.content)
                        .colorInvert()
                        .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        .font(.system(size: 15))
                        .lineLimit(2)
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height/23.5)
                        Spacer()
                    
                    Text(String(self.totalVotes))
                        .colorInvert()
                        .padding(.trailing,2)
                    
                }
                HStack{
                        Text(post.date_created)
                            .colorInvert()
                            .font(.system(size: 12))
                            .padding(.leading)
                        Spacer() 
                        Image(systemName: "text.bubble")
                            .colorInvert()
                        Text(String(post.comments))
                            .colorInvert()
                            .font(.system(size: 12))
                    Spacer()
                    
                    //downVote
                    Button(action:
                    {
                        if self.isDown == false && self.isUp == false
                        {
                            self.totalVotes -= 1
                            self.globalDirection = -1
                            self.isDown = true
                            self.downColor = Color.red
                            self.direction = -1
                        }
                        else if self.isDown == false && self.isUp == true
                        {
                            self.totalVotes -= 1
                            self.globalDirection = -1
                            self.isUp = false
                            self.upColor = Color.gray
                        }
                        else if self.isDown == true
                        {
                            self.totalVotes += 1
                            self.globalDirection = 1
                            self.isDown = false
                            self.downColor = Color.gray
                        }
                        
                        let defaults = UserDefaults.standard
                        let username = defaults.string(forKey: defaultsKeys.username)!
                        let voteObject: [String: Any]  =
                        [
                            "username": username,
                            "post_id": self.post.id,
                            "direction": self.direction,
                            "is_voted": self.isVoted,
                            "global_direction": self.globalDirection
                        ]
                        
                        self.isVoted = true
                        
                        API().submitVote(submitted: voteObject)
                    })
                    {
                        //Image(self.rec_clicked == true ? "rec_20_w" : "rec_20").resizable().frame(width:40, height:40).padding()
                        
                        
                        Image(systemName: self.isDown == true ? "arrowtriangle.down.fill" : "arrowtriangle.down" )
                            .resizable()
                            .frame(width:18,height:18)
                    
                    }//Nested HStack for date created and comments
                    .colorInvert()
                    .foregroundColor(self.downColor).buttonStyle(BorderlessButtonStyle())
               
                }
                }//End middle block of HStack
            .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height / 15.8)
            .padding(.bottom)
            .padding(.top)
            
        
            
            
         
//
//                    MetadataView(post: post,
//                                 isUp: self.$isUp,
//                                 isDown: self.$isDown,
//                                 totalVotes: self.$totalVotes,
//                                 upColor: self.$upColor,
//                                 downColor: self.$downColor,
//                                 isVoted: self.$isVoted)
//                            .font(.caption)
//                            .colorInvert()
//                            .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
//
//
//
//
//
        }
        
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height/9, alignment: .center)
        .background(Color.black)
        .listRowBackground(Color.black)
        .colorInvert()
        .cornerRadius(20)
        .border(Color.white, width: 2)
        
    }
    
}

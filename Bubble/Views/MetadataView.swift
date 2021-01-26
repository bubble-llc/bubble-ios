import SwiftUI

struct MetadataView: View {
    var post: Post
    
    @Binding var isUp: Bool
    @Binding var isDown: Bool
    @Binding var totalVotes: Int
    @Binding var upColor: Color
    @Binding var downColor: Color
    @Binding var isVoted: Bool
    
    @State private var showCommentForm: Bool = false
    @State var comments: [Comment] = []
    @State var globalDirection:Int = 0
    @State var direction:Int = 0
    @State private var downvote = false
    @State private var upVote = false

    var body: some View {
        VStack
        {
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
                    .padding(2)
                    
            }.foregroundColor(self.upColor).buttonStyle(BorderlessButtonStyle())
            
            
            Text(String(self.totalVotes))
        
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
                    .padding(2)
            }.foregroundColor(self.downColor).buttonStyle(BorderlessButtonStyle())
            
//            Button(action: {self.showCommentForm.toggle()})
//            {
//                Image(systemName: "text.bubble")
//                Text(String(post.comments))
//            }.foregroundColor(Color.primary).buttonStyle(BorderlessButtonStyle())
//            Spacer()
//            //print(post.date)
//            Text(post.date_created)
        }
    }
}

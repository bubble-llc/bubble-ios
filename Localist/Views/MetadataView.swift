import SwiftUI

struct MetadataView: View {
    var post: Post
    
    @State private var showCommentForm: Bool = false
    @State var comments: [Comment] = []
    @State var isUp = false
    @State var isDown = false
    @State var totalVotes:Int = 0
    @State var globalDirection:Int = 0
    @State var direction:Int = 0
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
    
    
    var body: some View {
        HStack
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
                let username = defaults.string(forKey: defaultsKeys.keyOne)!
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
                Image(systemName: "arrow.up")
            }.foregroundColor(self.upColor).buttonStyle(BorderlessButtonStyle())
            
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
                let username = defaults.string(forKey: defaultsKeys.keyOne)!
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
                Image(systemName: "arrow.down")
                Text(String(self.totalVotes))
            }.foregroundColor(self.downColor).buttonStyle(BorderlessButtonStyle())
            
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

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
    @State var upVotesOnly = false
    @State var downVotesOnly = false
    
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
                                                    isVoted: self.$isVoted,
                                                    upVotesOnly: self.$upVotesOnly,
                                                    downVotesOnly: self.$downVotesOnly)
            )
        {
            VStack(alignment: .leading, spacing: 0){
                Spacer()
                HStack{
                    Text(post.username)
                        .foregroundColor(Color.gray)
                        .font(.system(size: 12))
                        .padding(.leading)
                        .frame(width: UIScreen.main.bounds.width * 0.2, height: UIScreen.main.bounds.height * 0.001, alignment: .leading)
                    Spacer()
                    Text(post.title)
                        .font(.headline)
                        .lineLimit(1)
                        .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                        .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.02, alignment: .center)
                        Spacer()
                        Spacer()
                        }
                
                HStack{
                    
                    Image(systemName: "01.circle.fill")
                        .resizable()
                        .frame(width:30, height:30)
                        .padding(.leading)
                    Spacer()
                    Text(post.content)
                        .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        .font(.system(size: 15))
                        .lineLimit(2)
                        .padding(.leading, 3)
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height/24.5, alignment: .center)
                        
                    Spacer()
                }
                HStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                        Text(post.date_created)
                            .font(.system(size: 12))
                            .offset(x:7)
                        Spacer() 
                        Image(systemName: "text.bubble")
                        Text(String(post.comments))
                            .font(.system(size: 12))
                    Spacer()
                    }//Nested HStack for date created and comments
                Spacer()
                }//End middle block of HStack
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height / 15.8)
            .padding(.bottom)
            .padding(.top)

                    MetadataView(post: post,
                                 isUp: self.$isUp,
                                 isDown: self.$isDown,
                                 totalVotes: self.$totalVotes,
                                 upColor: self.$upColor,
                                 downColor: self.$downColor,
                                 isVoted: self.$isVoted,
                                 upVotesOnly: self.$upVotesOnly,
                                 downVotesOnly: self.$downVotesOnly)
                            .font(.caption)
                            .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
        }.onAppear {
            UITableViewCell.appearance().selectionStyle = .none
         }
        
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height/9, alignment: .center)
        .background(Color.white)
        .cornerRadius(20)
        .overlay(
            RoundedRectangle(cornerRadius: 20)
                .stroke(Color.white, lineWidth: 2)
        )
        
    }
    
}

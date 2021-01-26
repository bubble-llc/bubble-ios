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
                
//            VStack()
//            {
//                    Text(post.username)
//                        .colorInvert()
//                        .foregroundColor(Color.gray)
//                        .font(.system(size: 12))
//
//                    Image(systemName: "01.circle.fill")
//                        .resizable()
//                        .colorInvert()
//                        .frame(width:30, height:30)
//
//            }//VStack 1 of username and icon
//            .frame(width: UIScreen.main.bounds.width * 0.1, height: UIScreen.main.bounds.height / 10)
//
            
            VStack(alignment: .leading){
                HStack{
                    Text(post.username)
                        .colorInvert()
                        .foregroundColor(Color.gray)
                        .font(.system(size: 12))
                        .padding(.leading, 11)
                    Spacer()
                    Text(post.title)
                        .font(.headline)
                        .lineLimit(1)
                        .colorInvert()
                        .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))

                    Spacer()
                    
                }.padding(.top, 11)
                
                HStack{
                    
                    Image(systemName: "01.circle.fill")
                        .resizable()
                        .colorInvert()
                        .frame(width:30, height:30)
                        .padding(.leading, 15)
                    
                    Spacer()
                    Spacer()
                    Text(post.content)
                        .colorInvert()
                        .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        .frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height/30)
                    
                    Spacer()
                }
                HStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                        Text(post.date_created)
                            .colorInvert()
                            .font(.system(size: 12))
                            .offset(x:7)
                        Spacer()
                        Image(systemName: "text.bubble")
                            .colorInvert()

                        Text(String(post.comments))
                            .colorInvert()
                            .font(.system(size: 12))
                    Spacer()
                    }//Nested HStack for date created and comments
                .padding(.bottom, 13)
                }//End middle block of HStack
            .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height / 9.8)
            
            
            Spacer()
                    MetadataView(post: post,
                                 isUp: self.$isUp,
                                 isDown: self.$isDown,
                                 totalVotes: self.$totalVotes,
                                 upColor: self.$upColor,
                                 downColor: self.$downColor,
                                 isVoted: self.$isVoted)
                        .font(.caption)
                            .colorInvert()
                            .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))


            
            
            
        }
        
        .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height/10, alignment: .center)
        .background(Color.black)
        .listRowBackground(Color.black)
        .colorInvert()
        .cornerRadius(20)
        .border(Color.white, width: 2)
        
        
    }
    
}

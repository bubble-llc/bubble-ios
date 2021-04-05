import SwiftUI
import Request

struct CommentsView: View {
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
                HStack{
                Text(comment.username)
                    .font(.headline)
                    .font(.system(size: 14))
                    .lineLimit(1)
                    .colorInvert()
                    .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                    
                    
                Spacer()
                    Text(comment.date_created)
                    .colorInvert()
                    .font(.system(size: 12))
                
            }.padding(.top, 5)
            Spacer()
            HStack{
                Spacer()
            Text(comment.content)
                .colorInvert()
                .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                .font(.system(size: 15))
                .lineLimit(1)
                .padding(.bottom, 5)
//                Spacer()
//
//                MetadataView(post: post,
//                             isUp: self.$isUp,
//                             isDown: self.$isDown,
//                             totalVotes: self.$totalVotes,
//                             upColor: self.$upColor,
//                             downColor: self.$downColor,
//                             isVoted: self.$isVoted,
//                             upVotesOnly: self.$upVotesOnly,
//                             downVotesOnly: self.$downVotesOnly)
//                        .font(.caption)
//                        .colorInvert()
//                        .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
           Spacer()
            }.padding(.leading)
           
            
        
        
//            HStack(alignment: .center){
//
//                    Spacer()
//                VStack(){
//                    Text(post.date_created)
//                        .colorInvert()
//                        .font(.system(size: 12))
//                    Spacer()
//                    HStack{
//                    Image(systemName: "text.bubble")
//                        .colorInvert()
//                    Text(String(post.comments))
//                        .colorInvert()
//                        .font(.system(size: 12))
//                    }
//                }
//                VStack(alignment: .center){
//                    Text(post.title)
//                        .font(.headline)
//                        .lineLimit(1)
//                        .colorInvert()
//                        .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
//                        //.frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.02, alignment: .center)
//                        Spacer()
//                    Text(post.content)
//                        .colorInvert()
//                        .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
//                        .font(.system(size: 15))
//                        .lineLimit(2)
//                        .padding(.leading, 3)
//                        .padding(.bottom, 2)
//                        //.frame(width: UIScreen.main.bounds.width * 0.6, height: UIScreen.main.bounds.height/24.5, alignment: .center)
//                }.frame(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.0005, alignment: .center)
//                .padding(.leading, 40)
//
//
//            Spacer()
//                    MetadataView(post: post,
//                                 isUp: self.$isUp,
//                                 isDown: self.$isDown,
//                                 totalVotes: self.$totalVotes,
//                                 upColor: self.$upColor,
//                                 downColor: self.$downColor,
//                                 isVoted: self.$isVoted,
//                                 upVotesOnly: self.$upVotesOnly,
//                                 downVotesOnly: self.$downVotesOnly)
//                            .font(.caption)
//                            .colorInvert()
//                            .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
//                            .padding(.trailing, 12)
//
//
//            Spacer()
//
    //}
    }
    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.075, alignment: .center)
    .background(Color.black)
    .listRowBackground(Color.black)
    .colorInvert()
    .cornerRadius(20)
    .border(Color.white, width: 2)
    .buttonStyle(PlainButtonStyle())
    .buttonStyle(PlainButtonStyle())
}
} 


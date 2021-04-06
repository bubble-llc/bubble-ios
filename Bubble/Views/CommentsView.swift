import SwiftUI
import Request

struct CommentsView: View {
    let comment: Comment
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            
                HStack{
                Text(comment.username)
                    .colorInvert()
                    .font(.system(size: 12))
                    .lineLimit(1)
                    
                    .padding(.leading)
                    
                    Spacer()
                    Text(comment.date_created)
                        .colorInvert()
                    .font(.system(size: 10))
                        .padding(.trailing)
                
                }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.01, alignment: .center)
//                .overlay(
//                    RoundedRectangle(cornerRadius: 0)
//                        .stroke(Color.blue, lineWidth: 1)
//                )
            HStack{
                Spacer()
            Text(comment.content)
                .colorInvert()
                .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                .font(.system(size: 12))
                .lineLimit(3)
                //Char limit on iphone 8 is 43
                //Char limit on iphone 12 max is 99
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
            }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.06, alignment: .center)
//            .overlay(
//                RoundedRectangle(cornerRadius: 0)
//                    .stroke(Color.green, lineWidth: 1)
//            )
    }
        
    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.085)
        .background(Color.black)
        .colorInvert()
    .cornerRadius(25)
    .overlay(
        RoundedRectangle(cornerRadius: 25)
            .stroke(Color.white, lineWidth: 2)
    )
}
}




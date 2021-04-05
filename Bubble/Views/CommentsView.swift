import SwiftUI
import Request

struct CommentsView: View {
    let comment: Comment
    
    var body: some View {
        VStack(spacing: 0){
            
                HStack{
                Text(comment.username)
                    .colorInvert()
                    .font(.headline)
                    .font(.system(size: 14))
                    .lineLimit(1)
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
                .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
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
            }
    }
        
    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.075, alignment: .center)
        .background(Color.black)
        .colorInvert()
    .cornerRadius(25)
    .overlay(
        RoundedRectangle(cornerRadius: 25)
            .stroke(Color.white, lineWidth: 2)
    )
}
}




import SwiftUI
import Request

struct CommentsView: View {
    let comment: Comment
    @State private var isShowingDetailView = false
//    @Binding var isUp: Bool
//    @Binding var isDown: Bool
//    @Binding var totalVotes: Int
//    @Binding var upColor: Color
//    @Binding var downColor: Color
//    @Binding var isVoted: Bool
//    @Binding var upVotesOnly: Bool
//    @Binding var downVotesOnly: Bool
    @State var isUp = false
    @State var isDown = false
    @State var totalVotes:Int = 0
    @State var upColor = Color.gray
    @State var downColor = Color.gray
    @State var isVoted = false
    @State var upVotesOnly = false
    @State var downVotesOnly = false
    
    init(comment: Comment) {
        self.comment = comment
        self._totalVotes = State(initialValue: comment.votes)
        
        if comment.is_voted == true
        {
            self._isVoted = State(initialValue: true)
            if comment.prev_vote == 1
            {
                self._isUp = State(initialValue: true)
                self._upColor = State(initialValue: Color.green)
            }
            else if comment.prev_vote == -1
            {
                self._isDown = State(initialValue: true)
                self._downColor = State(initialValue: Color.red)
            }
        }
    }
    var body: some View {
        HStack{
        VStack(alignment: .leading, spacing: -3){
            
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
                .padding(.bottom, 2)
                //Char limit on iphone 8 is 43
                //Char limit on iphone 12 max is 99
                Spacer()
//

           
            }.frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.05, alignment: .center)
//            .overlay(
//                RoundedRectangle(cornerRadius: 0)
//                    .stroke(Color.green, lineWidth: 1)
//            )
            HStack{
//                Image(systemName: "ellipsis")
//                    .colorInvert()
//                    .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
//                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                HStack(spacing:0){
                Text(comment.username)
                    
                    //.foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                   // .foregroundColor(Color.black)
                    .font(.system(size: 10))
                    .bold()
                    .lineLimit(1)
                    .padding(.leading, UIScreen.main.bounds.width * 0.03)
                    Text(" - ")
                    
                    Text(comment.date_created)
                        
                        //.foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                        //.foregroundColor(Color.black)
                    .font(.system(size: 10))
                        .bold()
                }
                .colorInvert()
                .foregroundColor(Color(red: 66 / 255, green: 126 / 255, blue: 132 / 255))
                
                Spacer()
                MetadataView(comment: comment,
                             isUp: self.$isUp,
                             isDown: self.$isDown,
                             totalVotes: self.$totalVotes,
                             upColor: self.$upColor,
                             downColor: self.$downColor,
                             isVoted: self.$isVoted,
                             upVotesOnly: self.$upVotesOnly,
                             downVotesOnly: self.$downVotesOnly)
                        .font(.caption)
                        .colorInvert()
                        .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        .padding(.trailing, UIScreen.main.bounds.width * 0.05)
                }
            NavigationLink(destination: FeedbackView(), isActive: $isShowingDetailView) {
                            EmptyView()
                        }
    }
        
    .frame(width: UIScreen.main.bounds.width * 0.9, height: UIScreen.main.bounds.height * 0.085)
        .background(Color.black)
        .colorInvert()
    .cornerRadius(25)
    .overlay(
        RoundedRectangle(cornerRadius: 25)
            .stroke(Color.white, lineWidth: 2)
    )
//            Image(systemName: "ellipsis")
//                .rotationEffect(.degrees(90))
//                .foregroundColor(Color(red: 66 / 255, green: 126 / 255, blue: 132 / 255))
//                .padding(.trailing, UIScreen.main.bounds.width * 0.07)
//                .contextMenu{
//                    Button(action: {
//                       FeedbackView()
//                   }) {
//                       Text("Report Comment")
//                   }
//
//                }
            
            if #available(iOS 14.0, *) {
                Menu {
                    Button("Report Comment", action: {isShowingDetailView = true})
                } label: {
                    Label("", systemImage: "ellipsis").rotationEffect(.degrees(90))
                }
            } else {
                // Fallback on earlier versions
            }
            
            
            }
        
}
}




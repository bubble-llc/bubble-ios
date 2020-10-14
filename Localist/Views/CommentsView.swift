import SwiftUI
import Request

struct CommentsView: View {
    let comment: Comment
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                /// Body preview
                Group {
                        Text(comment.content)
                }
            }
        }
    }
}

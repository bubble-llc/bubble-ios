import SwiftUI
import SlideOverCard

struct UserLikedView: View {
    @State private var showSubmitPost: Bool = false
    @State private var showCreateUser: Bool = false
    @State private var post_content: String = ""
    @State private var position = CardPosition.bottom
    
    @Binding var userLatitude: String
    @Binding var userLongitude: String
    
    var body: some View {
        ZStack(alignment: .top){
                PostList(type: "liked", userLatitude: self.$userLatitude , userLongitude: self.$userLongitude, category: self.$userLongitude)
                    .navigationBarTitle(Text("Liked Post"), displayMode: .inline)
        }.padding(.top)
        .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
        
    }
}

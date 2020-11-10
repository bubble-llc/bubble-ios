import SwiftUI
import SlideOverCard

struct UserLikedView: View {
    @State private var showSubmitPost: Bool = false
    @State private var showCreateUser: Bool = false
    @State private var post_content: String = ""
    @State private var position = CardPosition.bottom
    
    @Binding var loggedIn: Bool
    @Binding var userLatitude: String
    @Binding var userLongitude: String
    
    var body: some View {
        ZStack{
            NavigationView {
                PostList(type: "liked", userLatitude: self.$userLatitude , userLongitude: self.$userLongitude, category: self.$userLongitude, loggedIn: self.$loggedIn)
                    .navigationBarTitle(Text("Liked Post"), displayMode: .inline)
                    .navigationBarItems(
                        leading: HStack
                        {
                            Button(action: {self.position = CardPosition.top}, label: {
                                    Image(systemName: "line.horizontal.3")
                            }).foregroundColor(.black)
                            
                        }
                    )
            }
        }.animation(.spring())
        menu(loggedIn: self.$loggedIn, userLatitude: self.$userLatitude , userLongitude: self.$userLongitude, position: self.$position)
    }
}

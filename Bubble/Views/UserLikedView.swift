import SwiftUI
import SlideOverCard

struct UserLikedView: View {
    var body: some View {
        ZStack(alignment: .top){
            LikedListView()
                .navigationBarTitle(Text("Liked Post"), displayMode: .inline)
        }.padding(.top)
        .background(Color("bubble_blue"))
        .edgesIgnoringSafeArea(.bottom)
    }
}

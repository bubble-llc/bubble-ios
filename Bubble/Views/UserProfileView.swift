import SwiftUI
import SlideOverCard

struct UserProfileView: View {
    @State var posts: [Post] = []
    var body: some View {

        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: defaultsKeys.username)!
        if #available(iOS 14.0, *) {
            ZStack(alignment: .top){
                VStack
                {
                    Text(username)
                        .font(.system(size:40))
                        .font(.headline)
                        .foregroundColor(Color.white)
                        .shadow(color: Color.black, radius: 3, y:1)
                        .padding(.top, UIScreen.main.bounds.height * 0.1)
                    Image("bubble_blue")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                    
                    List(posts){ post in

                        UserCreatedPostView(post: post)
                    }
                    .colorMultiply(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    .onAppear
                    {
                        API().getUserLikedPosts
                        {
                            (posts) in self.posts = posts
                            print(self.posts.count)
                        }
                    }
                    
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                
                
            }.background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
        } else {
            // Fallback on earlier versions
        }
        
    }
}

import SwiftUI
import SlideOverCard
struct UserProfileView: View {
    @State var posts: [Post] = []
    @State var postCount = 0
    
    @EnvironmentObject var categoryGlobal: Category
    
    var body: some View {
        let count = self.posts.count
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: defaultsKeys.username)!
        if #available(iOS 14.0, *) {
            ZStack(alignment: .top){
                
                VStack
                {
                    HStack{
                        Spacer()
                        Text(username)
                            .font(.system(size:40))
                            .font(.headline)
                            .foregroundColor(Color.white)
                            .shadow(color: Color.black, radius: 3, y:1)
                            .offset(x: UIScreen.main.bounds.height * 0.03)
                        Spacer()
                        NavigationLink(destination: UserAccountSettingsView()) {
                            Image(systemName: "gearshape").resizable().frame(width: UIScreen.main.bounds.width * 0.07, height: UIScreen.main.bounds.width * 0.07).foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                                    }.buttonStyle(PlainButtonStyle())
                        
                        .padding(.trailing, UIScreen.main.bounds.height * 0.03)
//                        Button(action:{}){
//                    Image(systemName: "gearshape")
//                        .resizable()
//                        .frame(width: UIScreen.main.bounds.width * 0.065, height: UIScreen.main.bounds.width * 0.065)
//                        .foregroundColor(Color.white)
//                        }
                    }
                    .padding(.top, UIScreen.main.bounds.height * 0.08)

                    Image("account_bubble_2x")
                        .resizable()
                        .frame(width: 200, height: 200, alignment: .center)
                    
                    Text(String(count) + " Bubbles")
                        .font(.system(size:25))
                        .font(.headline)
                        .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                        .bold()
                    
                    List(posts){ post in
                        
                        UserCreatedPostView(post: post)
                    }

                    .colorMultiply(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 2)
                    .buttonStyle(PlainButtonStyle())
                    .onAppear
                    {
                        API().getUserCreatedPosts
                        { (result) in
                            switch result
                            {
                                case .success(let posts):
                                    self.posts = posts
                                case .failure(let error):
                                    print(error)
                            }
                        }
                    }
                }
                .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                .buttonStyle(PlainButtonStyle())
                
                
            }.background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .onAppear(){
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
            }
        } else {
            // Fallback on earlier versions
        }
        
    }
}

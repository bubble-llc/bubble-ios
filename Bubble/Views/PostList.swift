import SwiftUI
import Request

struct PostList: View {
    @State var posts: [Post] = []
    
    let type: String
    @Binding var userLatitude: String
    @Binding var userLongitude: String
    @Binding var category: String
    
    @State private var categories = ["Deals", "Happy Hour", "Recreation", "What's Happening?", "Misc"]
    @State private var cat_icons = ["deals_20_w", "happy_20_w", "rec_20_w", "what_20_w", "misc_20_w"]
    
    @EnvironmentObject var categoryGlobal: Category
    
    var body: some View
    {
        if categories.contains(category)
        {
            
            let ind = categories.firstIndex(of: category)
            Spacer()
            HStack{
            Image(cat_icons[Int(ind!)])
            Text(category)
                .font(.system(size: 22))
                .bold()
                //.foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                .foregroundColor(Color.white)
                
            Image(cat_icons[Int(ind!)])
            }
        }
        
    
        
        List(posts){ post in

            PostView(post: post)
        }
        .colorMultiply(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                

        
        .onAppear
        {
            if(type == "feed"){
                var formatted_category = ""
                if category == "Happy Hour"
                {
                    formatted_category = "Happy_Hour"
                }
                else if category == "What's Happening?"
                {
                    formatted_category = "What's_Happening?"
                }
                else
                {
                    formatted_category = category
                }
                API().getPosts(logitude: userLongitude, latitude: userLatitude, category: formatted_category)
                {
                    (posts) in self.posts = posts
                }
             }
             else if(type == "liked"){
                 API().getUserLikedPosts
                 {
                     (posts) in self.posts = posts
                 }
             }
        }
        
    }
}


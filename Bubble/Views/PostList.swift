import SwiftUI
import Request

struct PostList: View {
    @State var posts: [Post] = []
    @State private var categories = ["Deals", "Happy Hour", "Recreation", "What's Happening?", "Misc"]
    @State private var cat_icons = ["deals_20_w", "happy_20_w", "rec_20_w", "what_20_w", "misc_20_w"]
    
    @Binding var category: String
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    
    var body: some View
    {
        List(posts){ post in

            PostView(post: post)
        }
        .colorMultiply(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                

        
        .onAppear
        {
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
            API().getPosts(logitude: locationViewModel.userLongitude, latitude: locationViewModel.userLatitude, category: category)
            {
                (posts) in self.posts = posts
            }
        }
        
    }
}


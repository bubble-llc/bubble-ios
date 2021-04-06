import SwiftUI
import Request

struct PostList: View {
    let categories = ["Deals":1, "Happy Hour":2, "Recreation":3, "What's Happening?":4, "Misc":5]
    
    @State var posts: [Post] = []
    
    @Binding var category: String
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var categoryGlobal: Category

    
    var body: some View
    {
        List(categoryGlobal.posts[categories[category]! - 1]){ post in

            PostView(post: post)
            
        }
        .colorMultiply(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
    }
}


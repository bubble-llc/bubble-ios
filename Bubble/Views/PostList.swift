import SwiftUI
import Request
import DeviceKit
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
            if #available(iOS 14.0, *) {
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
            } else {
                // Fallback on earlier versions
            }
            let device = Device.current

            print(device)     // prints, for example, "iPhone 6 Plus"

            if device == .simulator(.iPhone11) {
              print("fuck you")
            } else {
                print("No seriously fuck you")
            }
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


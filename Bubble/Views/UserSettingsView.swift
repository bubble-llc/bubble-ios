import SwiftUI
import Request
import Introspect


struct UserSettingsView: View {
    
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var username: String = "username"
    @State private var default_post_title: String = "Location of post"
    @State private var post_title_pressed: Bool = false
    @State private var post_content: String = "Write some content for your post"
    @State private var default_post_content: String = "Write some content for your post"
    @State private var post_content_pressed: Bool = false
    @State private var category_id = Constants.DEFAULT_CATEGORY
    @State private var showingAlert = false
    @State private var errorMessage = ""
    @State private var allNotifications = true
    @State private var commentNotifications = true
    @State private var likesNotifications = true
    
    @State private var deals_clicked = false
    @State private var happy_clicked = false
    @State private var rec_clicked = false
    @State private var what_clicked = false
    @State private var misc_clicked = false
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var categoryGlobal: Category
    
    var body: some View
    {
        
        if #available(iOS 14.0, *) {
            VStack(alignment: .leading){
                Spacer()
                Text("Account")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .font(.system(size: 40))
                    .foregroundColor(.white)
                    .padding(.leading, UIScreen.main.bounds.width * 0.2)
                Spacer()
                VStack(alignment: .leading) {
                    VStack(alignment:.leading){
                Text("User Settings")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    
                    Divider().frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.01).background(Color("bubble_dark")).padding(-5)
                    }
                Text("Username")
                    .foregroundColor(.white)
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                    TextEditor(text: $username)
                    .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.033)
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                HStack{//HStack containing the button to show/hide password form
                Text("Password")
                    .foregroundColor(.white)
                Image(systemName: "eye.slash")
                }
                .padding(.leading, UIScreen.main.bounds.width * 0.05)
            }//User Settings VStack
                .frame(width:UIScreen.main.bounds.width)
                .padding(.leading, -UIScreen.main.bounds.width * 0.45)
            Spacer()
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                Text("Privacy")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .padding(.leading, 2.5)
                    
                Divider().frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.01).background(Color("bubble_dark")).padding(-5)
                }
                HStack{//HStack containing the button to show/hide blocked users form
                Text("Blocked Users")
                    .foregroundColor(.white)
                Image(systemName: "eye.slash")
                }
                .padding(.leading, UIScreen.main.bounds.width * 0.05)
            }
            .padding(.leading, -UIScreen.main.bounds.width * 0.2)
                Spacer()
            VStack(alignment: .leading){
                VStack(alignment: .leading){
                Text("Notifications")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .padding(.leading, 2.5)
                    
                Divider().frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.01).background(Color("bubble_dark")).padding(-5)
                }
                Toggle("All Notifications", isOn: $allNotifications)
                    .foregroundColor(.white)
                    .toggleStyle(SwitchToggleStyle())
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                    .frame(width: UIScreen.main.bounds.width * 0.75)

                if allNotifications {
                    //Disable notifications logic here
                }
                
                Toggle("Comments on your posts", isOn: $commentNotifications)
                    .foregroundColor(.white)
                    .toggleStyle(SwitchToggleStyle())
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                    .frame(width: UIScreen.main.bounds.width * 0.75)

                if commentNotifications {
                    //Disable notifications logic here
                }
                
                Toggle("Likes on your posts", isOn: $likesNotifications)
                    .foregroundColor(.white)
                    .toggleStyle(SwitchToggleStyle())
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                    .frame(width: UIScreen.main.bounds.width * 0.75)
                if likesNotifications {
                    //Disable notifications logic here
                }
            }
            .padding(.leading, -UIScreen.main.bounds.width * 0.2)
            Spacer()
                Spacer()
        }//Encompassing VStack
            
        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
        .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
        } else {
            // Fallback on earlier versions
        }
               
    }
    
}

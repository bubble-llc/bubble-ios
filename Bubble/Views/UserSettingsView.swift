import SwiftUI
import Request
import Introspect


struct UserSettingsView: View {
    
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var username: String = ""
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
    @State var changePassword : Bool = false
    @State var showBlocked : Bool = false
    @State private var oldPassword = ""
    @State private var newPassword = ""
    @State private var confirmedPassword = ""
    
    
    @State private var deals_clicked = false
    @State private var happy_clicked = false
    @State private var rec_clicked = false
    @State private var what_clicked = false
    @State private var misc_clicked = false
    
    @EnvironmentObject var locationViewModel: LocationViewModel
    @EnvironmentObject var categoryGlobal: Category
    
    var body: some View
    {
        let defaults = UserDefaults.standard
        let actual_username = defaults.string(forKey: defaultsKeys.username)!
        if #available(iOS 14.0, *) {
            VStack(alignment: .leading){
                Spacer()
                VStack{
                Text("Account")
                    .font(.system(size: 50))
                    .foregroundColor(.white)
                    Divider().frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.01).background(Color("bubble_dark")).padding(-5)
                }
                .padding(.leading, UIScreen.main.bounds.width * 0.05)
                Spacer()
                VStack(alignment: .leading) {
                    VStack(alignment:.leading){
                Text("User Settings")
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .padding(.leading, 2.5)
                        
                    Divider().frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.width * 0.01).background(Color("bubble_dark")).padding(-5)
                    }
                Text("Change Username")
                    .foregroundColor(.white)
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                    
                    SecureField(" " + actual_username, text: $username)
                        .font(.system(size: 18))
                        .lineLimit(0)
                        .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                        .background(Color(.white))
                        .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        .cornerRadius(18)
                        .overlay(
                            RoundedRectangle(cornerRadius: 18)
                                .stroke(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255), lineWidth: 2)
                        )
                    .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.03)
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                HStack{//HStack containing the button to show/hide password form
                Text("Change Password")
                    .foregroundColor(.white)
                    Button(action:{
                        self.changePassword.toggle()
                    }){
                    Image(systemName: self.changePassword == false ? "eye.slash": "eye")
                        .foregroundColor(Color("bubble_dark"))
                    }
                }
                .padding(.leading, UIScreen.main.bounds.width * 0.05)
                    if changePassword{
                    Section{
                        SecureField("  Old password", text: $oldPassword)
                            .font(.system(size: 18))
                            .textContentType(.newPassword)
                            .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                            .background(Color(.white))
                            .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                            .cornerRadius(18)
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255), lineWidth: 2)
                            )
                            
                            .padding(.leading, UIScreen.main.bounds.width * 0.05)
                            .frame(width: UIScreen.main.bounds.width * 0.42)
                        SecureField("  New password", text: $newPassword)
                            .font(.system(size: 18))
                            .textContentType(.newPassword)
                            .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                            
                            .background(Color(.white))
                            .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                            .cornerRadius(18)
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255), lineWidth: 2)
                            )
                            
                            .padding(.leading, UIScreen.main.bounds.width * 0.05)
                            .frame(width: UIScreen.main.bounds.width * 0.42)
                        SecureField("  New password", text: $confirmedPassword)
                            .font(.system(size: 18))
                            .textContentType(.newPassword)
                            .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                            .background(Color(.white))
                            .cornerRadius(18)
                            .overlay(
                                RoundedRectangle(cornerRadius: 18)
                                    .stroke(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255), lineWidth: 2)
                            )
                            .padding(.leading, UIScreen.main.bounds.width * 0.05)
                            .frame(width:UIScreen.main.bounds.width * 0.42)
                    }
                    }

            }//User Settings VStack
                .frame(width:UIScreen.main.bounds.width)
                .padding(.leading, -UIScreen.main.bounds.width * 0.47)
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
                    Button(action:{
                        self.showBlocked.toggle()
                    }){
                    Image(systemName: self.showBlocked == false ? "eye.slash": "eye")
                        .foregroundColor(Color("bubble_dark"))
                    }
                }
                .padding(.leading, UIScreen.main.bounds.width * 0.05)
                
                if showBlocked{
                    List{
                        HStack{
                            Text("User 1")
                            Spacer()
                            Image(systemName: "trash")
                        }
                        HStack{
                            Text("User 2")
                            Spacer()
                            Image(systemName: "trash")
                        }
                        HStack{
                            Text("User 3")
                            Spacer()
                            Image(systemName: "trash")
                        }
                    }
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                    .frame(width:UIScreen.main.bounds.width * 0.42, height: UIScreen.main.bounds.height * 0.2)
                }
                
            }//Privacy VStack
            
            .padding(.leading, -UIScreen.main.bounds.width * 0.2)
                if !showBlocked{
                Spacer()
                }
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
                    .toggleStyle(SwitchToggleStyle(tint: Color("bubble_dark")))
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                    .frame(width: UIScreen.main.bounds.width * 0.75)

                if allNotifications {
                    //Disable notifications logic here
                }
                
                Toggle("Comments on your posts", isOn: $commentNotifications)
                    .foregroundColor(.white)
                    .toggleStyle(SwitchToggleStyle(tint: Color("bubble_dark")))
                    .padding(.leading, UIScreen.main.bounds.width * 0.05)
                    .frame(width: UIScreen.main.bounds.width * 0.75)

                if commentNotifications {
                    //Disable notifications logic here
                }
                
                Toggle("Likes on your posts", isOn: $likesNotifications)
                    .foregroundColor(.white)
                    .toggleStyle(SwitchToggleStyle(tint: Color("bubble_dark")))
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
            
            .ignoresSafeArea()
        .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
        .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            }

        
            else {
            // Fallback on earlier versions
        }
       
    }
    
}

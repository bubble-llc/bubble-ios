import SwiftUI
import SlideOverCard

struct UserProfileView: View {
    @State private var position = CardPosition.bottom
    
    var body: some View {
        ZStack{
            
                
                VStack
                {
                    let defaults = UserDefaults.standard
                    let username = defaults.string(forKey: defaultsKeys.username)!
                    let password = defaults.string(forKey: defaultsKeys.password)!
                    let email = defaults.string(forKey: defaultsKeys.email)!
                    let date_joined = defaults.string(forKey: defaultsKeys.date_joined)!
                    
                    Text("Username: \(username)")
                    Text("Password: \(password)")
                    Text("Email: \(email)")
                    Text("Date Joined: \(date_joined)")
                }.navigationBarTitle("Profile", displayMode: .inline)
//                    .navigationBarItems(leading: Button(action: {
//
//                        self.position = CardPosition.top
//
//                    }, label: {
//
//                        Image(systemName: "line.horizontal.3")
//                    }).foregroundColor(.black))
            
        }.animation(.spring())
        //menu(loggedIn: self.$loggedIn, userLatitude: self.$userLatitude , userLongitude: self.$userLongitude, position: self.$position)
        
    }
}

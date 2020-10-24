import SwiftUI

struct UserProfileView: View {
    @State var size = UIScreen.main.bounds.width / 1.6
    @Binding var loggedIn: Bool
    
    var body: some View {
        ZStack{
            NavigationView{
                
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
                    .navigationBarItems(leading: Button(action: {
                        
                        self.size = 10
                        
                    }, label: {
                        
                        Image(systemName: "gearshape.fill").resizable().frame(width: 20, height: 20)
                    }).foregroundColor(.black))
            }
            
            
            HStack{
                menu(size: $size, loggedIn: self.$loggedIn)
                .cornerRadius(20)
                    .padding(.leading, -size)
                    .offset(x: -size)
                
                Spacer()
            }
            
        }.animation(.spring())
        
    }
}

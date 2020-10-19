import SwiftUI

struct UserProfileView: View {
    @State var size = UIScreen.main.bounds.width / 1.6
    
    var body: some View {
        ZStack{
            NavigationView{
                
                VStack
                {
                    let defaults = UserDefaults.standard
                    let username = defaults.string(forKey: defaultsKeys.keyOne)!
                    let password = defaults.string(forKey: defaultsKeys.keyOne)!
                    Text("Username: \(username)")
                    Text("Password: \(password)")
                }.navigationBarTitle("Profile", displayMode: .inline)
                    .navigationBarItems(leading: Button(action: {
                        
                        self.size = 10
                        
                    }, label: {
                        
                        Image(systemName: "gearshape.fill").resizable().frame(width: 20, height: 20)
                    }).foregroundColor(.black))
            }
            
            
            HStack{
                menu(size: $size)
                .cornerRadius(20)
                    .padding(.leading, -size)
                    .offset(x: -size)
                
                Spacer()
            }
            
        }.animation(.spring())
        
    }
}

struct UserProfileView_Previews: PreviewProvider {
    static var previews: some View {
        UserProfileView()
    }
}

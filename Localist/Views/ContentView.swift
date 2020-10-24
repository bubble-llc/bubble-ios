import SwiftUI
import Request
import Combine

struct ContentView : View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var status: Int = 0
    @State private var showingAlert = false
    @State var showLoginView: Bool = false
    @State var showCreateUserView: Bool = false
    @State var users: [User] = []
    @EnvironmentObject var userAuth: UserAuth
    @ObservedObject var globalLogin = GlobalLogin()
    
    var body: some View {
        NavigationView(){
        
            
       let userauth = UserAuth()
        
                FeedView()

        }//navigation view
    }
    
    private func isUserInformationValid() -> Bool
    {
        if username.isEmpty
        {
            return false
        }
        
        if password.isEmpty
        {
            return false
        }
        
        return true
    }
}

struct ContentView_Previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
    }
}

struct defaultsKeys {
    static let username = "username"
    static let password = "password"
    static let email = "email"
    static let date_joined = "date_joined"
}


class UserAuth: ObservableObject {

  
    
  let didChange = PassthroughSubject<UserAuth,Never>()

  // required to conform to protocol 'ObservableObject'
  let willChange = PassthroughSubject<UserAuth,Never>()

@State private var showingAlert = false
   
@Published var isLoggedin: Bool = false
    
func login(username: String, password: String, users: [User]) -> Bool{
    var didLogin = false
 
    API().getUser(username: username, password:  password){ (users) in
        
        
        if(users.count != 0)
        {
            
            let defaults = UserDefaults.standard
            defaults.set(username, forKey: defaultsKeys.username)
            defaults.set(password, forKey: defaultsKeys.password)
            defaults.set(users[0].email, forKey: defaultsKeys.email)
            defaults.set(users[0].date_joined, forKey: defaultsKeys.date_joined)
            self.isLoggedin = true
            didLogin = true
            print(self.isLoggedin)
        }
        else
        {
            self.showingAlert = true
            print("failed")
        }
    }
    print(self.isLoggedin)
    
    return self.isLoggedin
    
  }



    // willSet {
    //       willChange.send(self)
    // }
  }

class GlobalLogin: ObservableObject {
  @Published var isLoggedIn = false
}

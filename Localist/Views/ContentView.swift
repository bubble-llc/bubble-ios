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
    @State private var loggedIn: Bool
    
    init() {
        let initialDefaults: NSDictionary =
        [
            "username": "username",
            "password": "password",
            "email": "email",
            "date_joined": "date_joined",
        ]
        UserDefaults.standard.register(defaults: initialDefaults as! [String : Any])
        
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: defaultsKeys.username)!
        print(username)
        
        if username != "username"
        {
            self._loggedIn = State(initialValue: true)
        }
        else
        {
            self._loggedIn = State(initialValue: false)
        }
        
        print(self._loggedIn)
    }
    var body: some View {
        
        NavigationView()
        {
            FeedView(loggedIn: self.$loggedIn)
        }
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
     
        API().getUser(username: username, password:  password){ (users) in
            if(users.count != 0)
            {
                
                let defaults = UserDefaults.standard
                defaults.set(username, forKey: defaultsKeys.username)
                defaults.set(password, forKey: defaultsKeys.password)
                defaults.set(users[0].email, forKey: defaultsKeys.email)
                defaults.set(users[0].date_joined, forKey: defaultsKeys.date_joined)
                self.isLoggedin = true
            }
            else
            {
                self.showingAlert = true
            }
        
        }
        return self.isLoggedin
    }
}

class GlobalLogin: ObservableObject {
  @Published var isLoggedIn = false
}

import SwiftUI
import Request

struct ContentView : View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var status: Int = 0
    @State private var showingAlert = false
    @State var showLoginView: Bool = false
    @State var users: [User] = []
    
    var body: some View {
        VStack {
            if showLoginView
            {
                FeedView()
            }
            else
            {
                Form {
                    HStack {
                        Image(systemName: "person")
                        TextField("Username", text: self.$username).autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.black))
                    HStack {
                        Image(systemName: "lock")
                        SecureField("Password", text: self.$password)
                    }
                    .padding()
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.black))
                    
                    Button(action: {
                        API().getUser(username: username, password:  password){ (users) in
                            self.users = users
                            
                            if(self.users.count != 0)
                            {
                                self.showLoginView = true
                                
                                let defaults = UserDefaults.standard
                                defaults.set(username, forKey: defaultsKeys.username)
                                defaults.set(password, forKey: defaultsKeys.password)
                                defaults.set(self.users[0].email, forKey: defaultsKeys.email)
                                defaults.set(self.users[0].date_joined, forKey: defaultsKeys.date_joined)
                            }
                            else
                            {
                                self.showingAlert = true
                            }
                        }
                    }, label: {
                        Text("Login")
                    })
                    .alert(isPresented: $showingAlert)
                    {
                        Alert(title: Text("Invalid Login"), message: Text("Please enter valid login"), dismissButton: .default(Text("Ok")))
                    }
                }
                
                NavigationLink(destination: CreateUserView())
                {
                    Text("Create User")
                                
                }
            }
        }
            
    }
    
    private func isUserInformationValid() -> Bool {
        if username.isEmpty {
            return false
        }
        
        if password.isEmpty {
            return false
        }
        
        return true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct defaultsKeys {
    static let username = "username"
    static let password = "password"
    static let email = "email"
    static let date_joined = "date_joined"
}



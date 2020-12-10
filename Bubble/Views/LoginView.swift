import SwiftUI

struct LoginView: View {

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State private var loggedIn: Bool = true
    @State var users: [User] = []

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
        
    @ObservedObject var locationViewModel = LocationViewModel()
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View{
        VStack
        {
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
                        
                        let defaults = UserDefaults.standard
                        defaults.set(username, forKey: defaultsKeys.username)
                        defaults.set(password, forKey: defaultsKeys.password)
                        defaults.set(self.users[0].email, forKey: defaultsKeys.email)
                        defaults.set(self.users[0].date_joined, forKey: defaultsKeys.date_joined)
                        userAuth.isLoggedin = true
                    }
                    else
                    {
                        self.showingAlert = true
                    }
                }
            }, label: {
                HStack {
                    Spacer()
                    Text("Login")
                    Spacer()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            })
            .alert(isPresented: $showingAlert)
            {
                Alert(title: Text("Invalid Login"), message: Text("Please enter valid login"), dismissButton: .default(Text("Ok")))
            }
            Spacer()
            HStack {
                Spacer()
                Text("Register")
                Spacer()
            }
            .font(.headline)
            .foregroundColor(.white)
            .padding()
            .background(Color.blue)
            .cornerRadius(10)
        }
        .padding()
    }
}

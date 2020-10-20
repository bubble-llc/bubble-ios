import SwiftUI

struct LoginView: View {

@State private var username: String = ""
@State private var password: String = ""
@State private var showingAlert = false
@State var users: [User] = []
    
var body: some View{
    VStack
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
                    let userauth = UserAuth()
                    DispatchQueue.main.async
                    {
                    if userauth.login(username: self.username, password: self.password,users: users){
                   
                        
                        if let window = UIApplication.shared.windows.first {
                        window.rootViewController = UIHostingController(rootView: ContentView())
                        window.makeKeyAndVisible()
                            }
                    }
                    else{
                        print("failed2")
                    
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

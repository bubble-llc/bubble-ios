import SwiftUI
import Request

struct ContentView : View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var status: Int = 0
    @State private var showingAlert = false
    @State var showLoginView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                if showLoginView {
                    FeedView()
                    .navigationBarTitle(Text("Feed"))
                } else {
                    Form {
                        TextField("Username", text: self.$username).autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        SecureField("Password", text: self.$password)
                        
                        if self.isUserInformationValid() {
                            Button(action: {
                                if API().validateUser(username: username, password:  password) == true
                                {
                                    self.showLoginView = true
                                }
                                else
                                {
                                    self.showingAlert = true
                                }
                            }, label: {
                                Text("Login")
                            })
                            .alert(isPresented: $showingAlert) {
                                        Alert(title: Text("Invalid Login"), message: Text("Please enter valid login"), dismissButton: .default(Text("Ok")))
                                    }
                        }
                    }.navigationBarTitle(Text("Login"))
                    
                    NavigationLink(destination: CreateUserView()) {
                                        Text("Create User")
                                    }
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
    static let keyOne = "firstStringKey"
    static let keyTwo = "secondStringKey"
}



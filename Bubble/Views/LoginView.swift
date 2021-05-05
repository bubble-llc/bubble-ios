import SwiftUI

struct LoginView: View {

    @State private var username: String = ""
    @State private var password: String = ""
    @State private var showingAlert = false
    @State var users: [User] = []

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var categoryGlobal: Category
    
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
                API().getUser(username: username, password:  password)
                { (result) in
                    switch result
                    {
                        case .success(let users):
                            self.users = users
                            print(self.users)
                            userAuth.setInfo(userInfo: [
                                "username": username,
                                "user_id": self.users[0].user_id,
                                "password": password,
                                "email": self.users[0].email,
                                "date_joined": self.users[0].date_joined
                            ])
                            categoryGlobal.fetchData()
                        case .failure(let error):
                            print(error)
                            print("got here")
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
            HStack{
                NavigationLink(destination: CreateUserView().environmentObject(userAuth).environmentObject(categoryGlobal))
                {
                    Spacer()
                    Text("Register")
                    Spacer()
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
                NavigationLink(destination: PasswordReset().environmentObject(userAuth).environmentObject(categoryGlobal))
                {
                    Text("Forgot Password")
                }
                .font(.headline)
                .foregroundColor(.white)
                .padding()
                .background(Color.blue)
                .cornerRadius(10)
            }
        }
        .padding()
    }
}

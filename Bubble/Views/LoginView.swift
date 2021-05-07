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
        if #available(iOS 14.0, *) {
            VStack
            {
                Image("b")
                    .resizable()
                    .frame(width: UIScreen.main.bounds.height * 0.3, height: UIScreen.main.bounds.height * 0.3)
                    .padding(.top, UIScreen.main.bounds.height * 0.1)
                    .padding(.bottom, UIScreen.main.bounds.height * 0.05)
                    .foregroundColor(Color.white)
                HStack {
                    Image(systemName: "person")
                    
                    ZStack(alignment: .leading) {
                            if username.isEmpty {
                                Text("Username")
                                    .foregroundColor(.white)
                            }
                            TextField("", text: $username)
                        }
                    
                }
                .foregroundColor(Color.white)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.white))
                .frame(width: UIScreen.main.bounds.width * 0.8)
                HStack {
                    Image(systemName: "lock")
                    ZStack(alignment: .leading){
                        if password.isEmpty{
                            Text("Password")
                                .foregroundColor(Color.white)
                        }
                    SecureField("", text: self.$password)
                    }
                }
                .foregroundColor(Color.white)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.white))
                .frame(width: UIScreen.main.bounds.width * 0.8)
                
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
                            .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        Spacer()
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    .frame(width: UIScreen.main.bounds.width * 0.8)
                })
                .alert(isPresented: $showingAlert)
                {
                    Alert(title: Text("Invalid Login"), message: Text("Please enter valid login"), dismissButton: .default(Text("Ok")))
                }
                HStack{
                    Spacer()
                    NavigationLink(destination: CreateUserView().environmentObject(userAuth).environmentObject(categoryGlobal))
                    {
                        Text("Register")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    Spacer()
                    NavigationLink(destination: PasswordReset().environmentObject(userAuth).environmentObject(categoryGlobal))
                    {
                        Text("Forgot Password")
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    Spacer()
                }
                Spacer()
            }
            .padding()
            .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .ignoresSafeArea()
            
        } else {
            // Fallback on earlier versions
        }
        Spacer()
        
    }
    
}

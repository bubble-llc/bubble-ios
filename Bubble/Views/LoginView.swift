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
                //            Image("dark_bubble")
                //                .resizable()
                //                .frame(width: UIScreen.main.bounds.width * 0.4, height: UIScreen.main.bounds.height * 0.2)
                Spacer()
                HStack {
                    Image(systemName: "person")
                    
                    TextField("Username", text: self.$username).autocapitalization(/*@START_MENU_TOKEN@*/.none/*@END_MENU_TOKEN@*/)
                        .foregroundColor(Color.white)
                }
                .foregroundColor(Color.white)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.white))
                HStack {
                    Image(systemName: "lock")
                    SecureField("Password", text: self.$password)
                        .foregroundColor(Color.white)
                }
                .foregroundColor(Color.white)
                .padding()
                .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(Color.white))
                
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
                })
                .alert(isPresented: $showingAlert)
                {
                    Alert(title: Text("Invalid Login"), message: Text("Please enter valid login"), dismissButton: .default(Text("Ok")))
                }
                HStack{
                    NavigationLink(destination: CreateUserView().environmentObject(userAuth).environmentObject(categoryGlobal))
                    {
                        Spacer()
                        Text("Register")
                            .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        Spacer()
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
                    NavigationLink(destination: PasswordReset().environmentObject(userAuth).environmentObject(categoryGlobal))
                    {
                        Text("Forgot Password")
                            .foregroundColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                    }
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.white)
                    .cornerRadius(10)
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

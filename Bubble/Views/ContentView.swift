import SwiftUI
import Request
import Combine
import SlideOverCard

class UserAuth: ObservableObject {
    let objectWillChange = ObservableObjectPublisher()
    
    var isLoggedin:Bool {
        willSet {
            objectWillChange.send()
        }
    }
    
    init() {
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: defaultsKeys.username)!
        if username != "username"
        {
            self.isLoggedin = true
        }
        else
        {
            self.isLoggedin = false
        }
    }
}

struct ContentView : View {
    @State var showLoginView: Bool = false
    @State var showCreateUserView: Bool = false
    @State var users: [User] = []
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var status: Int = 0
    @State private var showingAlert = false
    @State private var loggedIn = true
    @State private var userLatitude: String = ""
    @State private var userLongitude: String = ""
    
    @ObservedObject var locationViewModel = LocationViewModel()
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View {
        NavigationView(){
            if !userAuth.isLoggedin{
                LoginView().environmentObject(userAuth).navigationBarBackButtonHidden(true)
            }
            else{
                ScrollView {PageView(userLatitude: self.$locationViewModel.userLatitude , userLongitude: self.$locationViewModel.userLongitude).environmentObject(userAuth)
                }
            }
        }
    }
}

import SwiftUI
import Request
import Combine
import SlideOverCard

struct ContentView : View {
    @State var showLoginView: Bool = false
    @State var showCreateUserView: Bool = false
    @State var users: [User] = []
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var status: Int = 0
    @State private var showingAlert = false
    @State private var loggedIn: Bool
    @State private var userLatitude: String = ""
    @State private var userLongitude: String = ""
    
    @ObservedObject var locationViewModel = LocationViewModel()
    
    init() {
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: defaultsKeys.username)!
        
        if username != "username"
        {
            self._loggedIn = State(initialValue: true)
        }
        else
        {
            self._loggedIn = State(initialValue: false)
        }
    }
    var body: some View {
        NavigationView(){
            ScrollView {PageView(loggedIn: self.$loggedIn, userLatitude: self.$locationViewModel.userLatitude , userLongitude: self.$locationViewModel.userLongitude)
            }
        }
    }
}


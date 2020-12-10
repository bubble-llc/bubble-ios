import SwiftUI
import Request
import Combine
import SlideOverCard

struct ContentView : View {
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

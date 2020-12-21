import SwiftUI
import Request
import Combine
import SlideOverCard

struct ContentView : View {
    @State private var userLatitude: String = ""
    @State private var userLongitude: String = ""
    
    @ObservedObject var locationViewModel = LocationViewModel()
    @EnvironmentObject var userAuth: UserAuth
    @State var show = false
    
    var body: some View {
        NavigationView(){
            if !userAuth.isLoggedin{
                LoginView().environmentObject(userAuth).navigationBarBackButtonHidden(true)
            }
            else{
                ZStack{
                    ScrollView {PageView(userLatitude: self.$locationViewModel.userLatitude , userLongitude: self.$locationViewModel.userLongitude).environmentObject(userAuth)}
                    GeometryReader{_ in
                        HStack{
                            MenuView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude)
                                .offset(x: self.show ? 0 : -UIScreen.main.bounds.width)
                                .animation(.default)
                            Spacer()
                        }
                    }.background(Color.black.opacity(self.show ? 0.2 : 0)).edgesIgnoringSafeArea(.bottom)
                }.navigationBarTitle("Home",displayMode: .inline)
                .navigationBarItems(leading:
                    Button(action: {
                        self.show.toggle()
                    }, label: {
                        if self.show{
                            Image(systemName: "arrow.left").font(.body).foregroundColor(.black)
                        }
                        else{
                            Image(systemName: "line.horizontal.3")
                        }
                    })
                )
            }
        }
    }
}

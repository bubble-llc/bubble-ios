import SwiftUI
import Request
import Combine
import SlideOverCard

struct ContentView : View {
    @State private var userLatitude: String = ""
    @State private var userLongitude: String = ""
    
    @ObservedObject var locationViewModel = LocationViewModel()
    @ObservedObject var category = Category()
    
    @EnvironmentObject var userAuth: UserAuth
    @State var show = false
    
    var body: some View {
        NavigationView(){
            if !userAuth.isLoggedin{
                LoginView().environmentObject(userAuth).navigationBarBackButtonHidden(true)
            }
            else{
                if #available(iOS 14.0, *) {
                    ZStack{
                        
                        PageView(userLatitude: self.$locationViewModel.userLatitude , userLongitude: self.$locationViewModel.userLongitude).environmentObject(userAuth)
                        //                    TabBarView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude)
                        
                        GeometryReader{_ in
                            HStack{
                                MenuView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude)
                                    .offset(x: self.show ? 0 : -UIScreen.main.bounds.width)
                                    .animation(.default)
                                
                            }
                            
                        }.background(Color.black.opacity(self.show ? 0.2 : 0)).edgesIgnoringSafeArea(.bottom)
                        
                        
                        
                    }.navigationBarTitle(self.category.currCategory, displayMode: .inline)
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
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}

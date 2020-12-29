import SwiftUI
import Request
import Combine
import SlideOverCard

struct ContentView : View {
    @State private var userLatitude: String = ""
    @State private var userLongitude: String = ""
    @State var show = false
    
    @ObservedObject var locationViewModel = LocationViewModel()
    
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var categoryGlobal: Category
    
    var body: some View {
        NavigationView(){
            if !userAuth.isLoggedin{
                LoginView().environmentObject(userAuth).navigationBarBackButtonHidden(true)
            }
            else{
                if #available(iOS 14.0, *) {
                    
                    ZStack{
                        
                        PageView(userLatitude: self.$locationViewModel.userLatitude , userLongitude: self.$locationViewModel.userLongitude).environmentObject(userAuth).environmentObject(categoryGlobal)
                        //                    TabBarView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude)
                        
                        GeometryReader{_ in
                            HStack{
                                MenuView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude)
                                    .offset(x: self.show ? 0 : -UIScreen.main.bounds.width)
                                    .animation(.default)
                                
                            }
                            
                        }.background(Color.black.opacity(self.show ? 0.2 : 0)).edgesIgnoringSafeArea(.bottom)
                        
                        
                        
                    }
                    .navigationBarTitle(categoryGlobal.currCategory, displayMode: .inline)
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
                                            }), trailing:
                                                NavigationLink(destination: SubmitPostView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude)){
                                                    Text("Submit")
                                                }
                                    
                                  
                    )
                } else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}

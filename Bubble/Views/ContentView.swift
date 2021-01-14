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
        
        let drag = DragGesture()
          .onEnded {
              if $0.translation.width < -100 {
                  withAnimation {
                      self.show = false
                  }
              }
          }
        
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
                                
                            }    .gesture(drag).onAppear {
                                self.show = false
                            }
                            
                        }.background(Color.black.opacity(self.show ? 0.2 : 0)).edgesIgnoringSafeArea(.bottom)
                        
                        
                        
                    }.navigationBarTitle("home", displayMode: .inline)
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
                    
                    .onAppear(){
                        UITableView.appearance().backgroundColor = .cyan
                        UITableViewCell.appearance().backgroundColor = .cyan
                    }
                }
                
                else {
                    // Fallback on earlier versions
                }
            }
        }
    }
}

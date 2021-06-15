import SwiftUI
import Request
import Combine
import SlideOverCard

struct ContentView : View {
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var categoryGlobal: Category
    
    @State var showMenu = false
    
    let locationViewModel = LocationViewModel()
    
    init() {
        //Use this if NavigationBarTitle is with Large Font
        UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.white]

        //Use this if NavigationBarTitle is with displayMode = .inline
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
     
    
    var body: some View {
        
        let drag = DragGesture()
          .onEnded {
              if $0.translation.width < -100 {
                  withAnimation {
                      self.showMenu = false
                  }
              }
          }
        
        NavigationView(){
            if(!userAuth.isLoggedin){
                LoginView().environmentObject(userAuth).environmentObject(categoryGlobal).navigationBarBackButtonHidden(true)
                    .navigationBarTitle(Text(""), displayMode: .inline)
                    .navigationBarHidden(true)
            }
            else if(categoryGlobal.fetching){
                
                if #available(iOS 14.0, *) {
 
                    ZStack{
                        
                        PageView().environmentObject(userAuth).environmentObject(locationViewModel).environmentObject(categoryGlobal)

                        GeometryReader{_ in

                            MenuView(showMenu: $showMenu)
                                    .offset(x: self.showMenu ? 0 : -UIScreen.main.bounds.width)
                                    .animation(.default)
                                    .environmentObject(userAuth)
                                    .environmentObject(locationViewModel)
                                    .environmentObject(categoryGlobal)
                            
                        }
                        .background(Color.black.opacity(self.showMenu ? 0.2 : 0))
                        .onTapGesture{
                            self.showMenu.toggle()
                        }
                        .gesture(drag)
                    }
                    .navigationBarTitle(Text(""), displayMode: .inline)
                    .toolbar{
                        ToolbarItem(placement: .principal){
                            HStack{
                                if categoryGlobal.categories.contains(categoryGlobal.currCategory)
                                {
                                    let ind = categoryGlobal.categories.firstIndex(of: categoryGlobal.currCategory)
                                    Image(categoryGlobal.cat_icons[Int(ind!)])
                                    Text(categoryGlobal.currCategory)
                                        .foregroundColor(Color.white)
                                        .bold()
                                        .font(.headline)
                                    Image(categoryGlobal.cat_icons[Int(ind!)])
                                }
                            }
                        }
                    }
                    .navigationBarItems(leading:
                                            HStack{
                                            Button(action: {
                                                self.showMenu.toggle()
                                            }, label: {
                                                if self.showMenu{
                                                    Image("bubble_menu").resizable().foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                                                }
                                                else{
                                                    Image("bubble_menu")
                                                        .resizable()
                                                        .foregroundColor(Color.white)
                                                }
                                            })
                                            }, trailing:
                                                NavigationLink(destination: SubmitPostView().environmentObject(locationViewModel).environmentObject(categoryGlobal)){
                                                    Image(systemName: "plus")
                                                        .foregroundColor(Color.white)
                                                }


                    )
                }
            }
            else{
                Text("waiting").onAppear
                {
                    categoryGlobal.fetchData()
                }
            }
        }
    }
}

extension UINavigationController: UIGestureRecognizerDelegate {
    override open func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }

    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
}

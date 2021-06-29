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
                                    //selectedTab == i ? Image(categoryGlobal.selected_cat_names1[i])
                                    Int(ind!) == 2 ? Image(categoryGlobal.cat_icons[Int(ind!)])
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width * 0.09 , height: UIScreen.main.bounds.width * 0.09)
                                        : Image(categoryGlobal.cat_icons[Int(ind!)])
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.width * 0.069 , height: UIScreen.main.bounds.width * 0.069)
                                    Text(categoryGlobal.currCategory)
                                        //.font(.custom("SCRIPT MT BOLD", size: 25))
                                        .font(.custom("Freehand575 BT", size: 36))
                                        //.font(.custom("Adenture Scriptine", size: 25))
                                        //.font(.custom("Back to Black Demo", size: 25))
                                        .foregroundColor(Color.white)
                                    Int(ind!) == 2 ? Image(categoryGlobal.cat_icons[Int(ind!)])
                                        .resizable()
                                        .frame(width: UIScreen.main.bounds.width * 0.09 , height: UIScreen.main.bounds.width * 0.09)
                                        : Image(categoryGlobal.cat_icons[Int(ind!)])
                                            .resizable()
                                            .frame(width: UIScreen.main.bounds.width * 0.069 , height: UIScreen.main.bounds.width * 0.069)
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
                                                    Image("bubble_menu")
                                                        .resizable()
                                                        .frame(width: UIScreen.main.bounds.width * 0.069 , height: UIScreen.main.bounds.width * 0.069)
                                                        .foregroundColor(Color("bubble_dark"))
                                                }
                                                else{
                                                    Image("bubble_menu")
                                                        .resizable()
                                                        .frame(width: UIScreen.main.bounds.width * 0.069 , height: UIScreen.main.bounds.width * 0.069)
                                                        .foregroundColor(Color.white)
                                                }
                                            })
                                            }, trailing:
                                                NavigationLink(destination: SubmitPostView().environmentObject(locationViewModel).environmentObject(categoryGlobal)){
                                                    Image(systemName: "plus.circle")
                                                        .resizable()
                                                        .frame(width: UIScreen.main.bounds.width * 0.069 , height: UIScreen.main.bounds.width * 0.069)
                                                        .foregroundColor(Color.white)
                                                }


                    )
                }
            }
            else{
                if #available(iOS 14.0, *) {
                    VStack{
                        Image("b_300")
                            .resizable()
                            .frame(width: 500, height: 500)
                            .foregroundColor(Color("bubble_dark"))
                            .opacity(0.6)
                            
                            .onAppear
                            {
                                categoryGlobal.fetchData()
                            }
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    .background(Color("bubble_blue"))
                    .ignoresSafeArea()
                } else {
                    // Fallback on earlier versions
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

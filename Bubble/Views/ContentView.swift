import SwiftUI
import Request
import Combine
import SlideOverCard

struct ContentView : View {
    
    @EnvironmentObject var userAuth: UserAuth
    @EnvironmentObject var categoryGlobal: Category
    
    @State private var categories = ["Deals", "Happy Hour", "Recreation", "What's Happening?", "Misc"]
    @State private var cat_icons = ["dealsf1", "hhf1", "recf1", "whf1", "miscf1"]
    
    @State var show = false
    
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
                      self.show = false
                  }
              }
          }
        
        NavigationView(){
            if !userAuth.isLoggedin{
                LoginView().environmentObject(userAuth).environmentObject(categoryGlobal).navigationBarBackButtonHidden(true)
                    .navigationBarTitle(Text(""), displayMode: .inline)
                    .navigationBarHidden(true)
            }
            else{
                
                if #available(iOS 14.0, *) {
 
                    ZStack{
                        
                        PageView().environmentObject(userAuth).environmentObject(locationViewModel)

                        GeometryReader{_ in

                                MenuView()
                                    .offset(x: self.show ? 0 : -UIScreen.main.bounds.width)
                                    .animation(.default)
                                    .environmentObject(userAuth)
                                    .environmentObject(locationViewModel)
                            
                        }
                        .background(Color.black.opacity(self.show ? 0.2 : 0))
                        .onTapGesture{
                            self.show.toggle()
                        }
                        .gesture(drag)
                    }
                    .navigationBarTitle(Text(""), displayMode: .inline)
                    .toolbar{
                        ToolbarItem(placement: .principal){
                            HStack{
                                if categories.contains(categoryGlobal.currCategory)
                                {
                                    let ind = categories.firstIndex(of: categoryGlobal.currCategory)
                                    Image(cat_icons[Int(ind!)])
                                    Text(categoryGlobal.currCategory)
                                        .foregroundColor(Color.white)
                                        .bold()
                                        .font(.headline)
                                    Image(cat_icons[Int(ind!)])
                                }
                            }
                        }
                    }
                    .navigationBarItems(leading:
                                            HStack{
                                            Button(action: {
                                                self.show.toggle()
                                            }, label: {
                                                if self.show{
                                                    Image("bubble_menu").resizable().foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                                                }
                                                else{
                                                    Image("bubble_menu")
                                                        .resizable()
                                                        .foregroundColor(Color.white)
                                                }
                                            })
                                            }, trailing:
                                                NavigationLink(destination: SubmitPostView().environmentObject(locationViewModel)){
                                                    Image(systemName: "plus")
                                                        .foregroundColor(Color.white)
                                                }


                    )
                    
                    .onAppear(){
                        UITableView.appearance().backgroundColor = UIColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        UITableViewCell.appearance().backgroundColor = UIColor(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        
                    }
                }
                
                else {
                    // Fallback on earlier versions

                }
            }
        }
    }
}

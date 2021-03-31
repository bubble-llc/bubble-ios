import SwiftUI
import Request

struct SubmitPostView: View {
    
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var post_title: String = "Location of post"
    @State private var post_title_pressed: Bool = false
    @State private var post_content: String = "Write some content for your post"
    @State private var post_content_pressed: Bool = false
    @State private var category_id = 0
    @State private var showingAlert = false
    @State private var errorMessage = ""
    
    @State private var deals_clicked = false
    @State private var happy_clicked = false
    @State private var rec_clicked = false
    @State private var what_clicked = false
    @State private var misc_clicked = false
    
    @EnvironmentObject var locationViewModel: LocationViewModel

//    init(userLatitude: Binding<String>, userLongitude: Binding<String>){
//        self._userLatitude = userLatitude
//        self._userLongitude = userLongitude
//        UITableView.appearance().backgroundColor = .cyan
//        UITableViewCell.appearance().backgroundColor = .cyan
//        }

    var body: some View
    {

        if #available(iOS 14.0, *) {
            Form {
                Text("Create Your Post").font(.system(size: 30))
                    .bold()
                    .italic()
                    .foregroundColor(Color.white)
                    .shadow(color: Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255), radius: 2)
                    .offset(x: UIScreen.main.bounds.width * 0.125)
                    .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                
//                HStack{
//                    Image("bubbles_20")//(systemName: self.isPlaying == true ? "pause.fill" : "play.fill")
//                        .resizable()
//                Image("bubble_rough")//(systemName: self.isPlaying == true ? "pause.fill" : "play.fill")
//                    .resizable()
//                }.listRowBackground(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
                VStack{
                    Text("Category")
                        .font(.headline)
                        .bold()
                        .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                        .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        .shadow(color: .white, radius: 5)
                        .offset(x: -UIScreen.main.bounds.width * 0.35)
                HStack{
                    Spacer()
                    
                    //Deals Button
                    Button(action: {
                        deals_clicked.toggle()
                        
                        happy_clicked = false
                        rec_clicked = false
                        what_clicked = false
                        misc_clicked = false
                        
                        category_id = 1
                    }){
                        
                        Image(self.deals_clicked == true ? "dealsf1" : "deals1").resizable().frame(width:40, height:40).padding()
                        //Text("Deals")
                    }.buttonStyle(PlainButtonStyle())
                    //Happy Hour
                    Button(action: {
                        happy_clicked.toggle()
                        
                        deals_clicked = false
                        rec_clicked = false
                        what_clicked = false
                        misc_clicked = false
                        
                        category_id = 2
                    }){
                        
                        Image(self.happy_clicked == true ? "hhf1" : "hh1").resizable().frame(width:40, height:40).padding()
                       // Text("Happy Hour")
                    }.buttonStyle(PlainButtonStyle())
                    //Recreation
                    Button(action: {
                        rec_clicked.toggle()
                        
                        deals_clicked = false
                        happy_clicked = false
                        what_clicked = false
                        misc_clicked = false
                        
                        category_id = 3
                    }){
                        
                        Image(self.rec_clicked == true ? "recf1" : "rec1").resizable().frame(width:40, height:40).padding()
                        //Text("Recreation")
                    }.buttonStyle(PlainButtonStyle())
                    //What's Happening?
                    Button(action: {
                        what_clicked.toggle()
                        
                        deals_clicked = false
                        rec_clicked = false
                        happy_clicked = false
                        misc_clicked = false
                        
                        category_id = 4
                    }){
                        
                        Image(self.what_clicked == true ? "whf1" : "wh1").resizable().frame(width:40, height:40).padding()
                       // Text("What's Happening?")
                    }.buttonStyle(PlainButtonStyle())
                    
                    //Misc
                    Button(action: {
                        misc_clicked.toggle()
                        
                        deals_clicked = false
                        rec_clicked = false
                        what_clicked = false
                        happy_clicked = false
                        
                        category_id = 5
                    }){//(systemName: self.isPlaying == true ? "pause.fill" : "play.fill")
                        Image(self.misc_clicked == true ? "miscf1" : "misc1").resizable().frame(width:40, height:40).padding()
                    }.buttonStyle(PlainButtonStyle())
                    
//                    Text("Category")
//                        .offset(x:-5)
//                        .foregroundColor(Color.blue)
//                        .font(.headline)

//                    Picker(selection: $selectedCategory, label: Text("")) {
//                        ForEach(0 ..< categories.count) {
//                            Text(self.categories[$0])
//                        }
                //}
                }.background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                .frame(width:UIScreen.main.bounds.width*0.8, alignment: .center)
                    
                }
                .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                if #available(iOS 14.0, *)
                {
                    VStack{
                        Text("Where").font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                            .shadow(color: .white, radius: 5)
                            .offset(x: -UIScreen.main.bounds.width * 0.35)
                        TextEditor(text: self.$post_title)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 35, maxHeight: 55)
                            .foregroundColor(post_title_pressed ? Color.black : Color.gray)
                            .background(Color.white)
                            .multilineTextAlignment(.leading)
                            .cornerRadius(25)
                            .onTapGesture {
                                if !self.post_title_pressed{
                                    self.post_title = ""
                                    self.post_title_pressed = true
                                }
                                
                            }
                        
                        
                        Text("Content").font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                            .shadow(color: .white, radius: 5)
                            .offset(x: -UIScreen.main.bounds.width * 0.35)
                        TextEditor(text: self.$post_content)
                            .padding()
                            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 200, maxHeight: 350)
                            
                            .foregroundColor(post_content_pressed ? Color.black : Color.gray)
                            .background(Color.white)
                            .multilineTextAlignment(.leading)
                            .cornerRadius(25)
                            .onTapGesture {
                                if !self.post_content_pressed{
                                    self.post_content = ""
                                    self.post_content_pressed = true
                                }
                                
                            }
                    }.background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                    .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                }
                else
                {
                    MultilineTextField("Enter post here...", text: self.$post_content)
                        .padding(3)
                        .frame(minWidth: 100, idealWidth: 100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center)
                        .background(RoundedRectangle(cornerRadius:5))
                }

                Button(action:
                        {
                            let defaults = UserDefaults.standard
                            let user_id = defaults.string(forKey: defaultsKeys.user_id)!
                            
                            if post_title == "" || post_title == "Location of post"
                            {
                                self.showingAlert = true
                                self.errorMessage = "Enter in value for Where"
                            }
                            
                            if post_content == "" || post_content == "Write some content for your post"
                            {
                                self.showingAlert = true
                                self.errorMessage = "Enter in value for Content"
                            }
                            
                            if !showingAlert
                            {
                                print(category_id)
                                let postObject: [String: Any]  =
                                    [
                                        "user_id": user_id,
                                        "category_id": category_id,
                                        "content": self.post_content,
                                        "title": self.post_title,
                                        "latitude": locationViewModel.userLatitude,
                                        "longitude": locationViewModel.userLongitude
                                    ]
                                API().submitPost(submitted: postObject)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            
                        })
                {
                    
                    Text("Submit")
                        .fontWeight(.bold)
                        .padding(10)
                        .background(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                        .cornerRadius(40)
                        .foregroundColor(.white)
                    
                }
                .buttonStyle(PlainButtonStyle())
                .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                .alert(isPresented: $showingAlert)
                {
                    Alert(title: Text("Missing Arguments"), message: Text(self.errorMessage), dismissButton: .default(Text("Ok")))
                }
            }
            
            .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .ignoresSafeArea()
        } else {
            // Fallback on earlier versions
        }
        
    }
}

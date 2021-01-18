import SwiftUI
import Request

struct SubmitPostView: View {
    
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var post_title: String = "Location of post"
    @State private var post_title_pressed: Bool = false
    @State private var post_content: String = "Write some content for your post"
    @State private var post_content_pressed: Bool = false
    @State private var selectedCategory = 0
    @State private var categories = ["Deals", "Happy Hour", "Recreation", "What's Happening?", "Misc"]
    @State private var showingAlert = false
    @State private var errorMessage = ""
    
    @Binding var userLatitude: String
    @Binding var userLongitude: String

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
                Image("bubble_rough")//(systemName: self.isPlaying == true ? "pause.fill" : "play.fill")
                    .resizable()
                    .frame(width:375, height:100)
                    .listRowBackground(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
                VStack{
                    Text("Category")
                        .font(.headline)
                        .foregroundColor(Color.blue)
                        .fontWeight(.bold)
                        .listRowBackground(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
                
                HStack{
                    Spacer()
                    
                    //Deals Button
                    Button(action: {
                        print("button pressed")
                    }){
                        
                        Image("deals_20").resizable().frame(width:40, height:40).padding()
                        //Text("Deals")
                    }.buttonStyle(PlainButtonStyle())
                    //Happy Hour
                    Button(action: {
                        print("button pressed")
                    }){
                        
                        Image("happy_20").resizable().frame(width:40, height:40).padding()
                       // Text("Happy Hour")
                    }.buttonStyle(PlainButtonStyle())
                    //Recreation
                    Button(action: {
                        print("button pressed")
                    }){
                        
                        Image("rec_20").resizable().frame(width:40, height:40).padding()
                        //Text("Recreation")
                    }.buttonStyle(PlainButtonStyle())
                    //What's Happening?
                    Button(action: {
                        print("button pressed")
                    }){
                        
                        Image("what_20").resizable().frame(width:40, height:40).padding()
                       // Text("What's Happening?")
                    }.buttonStyle(PlainButtonStyle())
                    
                    //Misc
                    Button(action: {
                        print("button pressed")
                    }){
                        Image("misc_20").resizable().frame(width:40, height:40).padding()
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
                }.background(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
                .listRowBackground(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
                .offset(x:-25)
                }
                .listRowBackground(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
                if #available(iOS 14.0, *)
                {
                    VStack{
                        Text("Where").font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(Color.blue)
                            .offset(x:-145)
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
                            .foregroundColor(Color.blue)
                            .offset(x:-142)
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
                    }.background(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
                    .listRowBackground(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
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
                            let username = defaults.string(forKey: defaultsKeys.username)!
                            var formatted_category = categories[selectedCategory]
                            if formatted_category == "Happy Hour"
                            {
                                formatted_category = "Happy_Hour"
                            }
                            else if formatted_category == "What's Happening?"
                            {
                                formatted_category = "What's_Happening?"
                            }
                            
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
                                let postObject: [String: Any]  =
                                    [
                                        "username": username,
                                        "category_name": formatted_category,
                                        "content": self.post_content,
                                        "title": self.post_title,
                                        "latitude": userLatitude,
                                        "longitude": userLongitude
                                    ]
                                API().submitPost(submitted: postObject)
                                self.presentationMode.wrappedValue.dismiss()
                            }
                            
                        })
                {
                    
                    Text("Submit")
                        .fontWeight(.bold)
                        .padding(10)
                        .background(Color.blue)
                        .cornerRadius(40)
                        .foregroundColor(.white)
                    
                }
                .buttonStyle(PlainButtonStyle())
                .listRowBackground(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
                .alert(isPresented: $showingAlert)
                {
                    Alert(title: Text("Missing Arguments"), message: Text(self.errorMessage), dismissButton: .default(Text("Ok")))
                }
            }
            
            .background(Color(red: 0 / 255, green: 255 / 255, blue: 255 / 255))
            .onAppear(){
                UITableView.appearance().backgroundColor = .cyan
                UITableViewCell.appearance().backgroundColor = .cyan
            }
            .ignoresSafeArea()
        } else {
            // Fallback on earlier versions
        }
        
    }
}

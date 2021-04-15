import SwiftUI
import Request
import Introspect


struct SubmitPostView: View {
    
    
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    @State private var post_title: String = "Location of post"
    @State private var default_post_title: String = "Location of post"
    @State private var post_title_pressed: Bool = false
    @State private var post_content: String = "Write some content for your post"
    @State private var default_post_content: String = "Write some content for your post"
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
    @EnvironmentObject var categoryGlobal: Category
    
    var body: some View
    {
        if #available(iOS 14.0, *) {
            VStack {
                if #available(iOS 14.0, *) {
                    Text("Create Your Post").font(.system(size: 30))
                        .bold()
                        .italic()
                        .foregroundColor(Color.white)
                        .shadow(color: Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255), radius: 2)
                        .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        .padding(.top, UIScreen.main.bounds.height * 0.1)
                    
                    Text("Category")
                        .font(.headline)
                        .bold()
                        .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                        .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        .shadow(color: .white, radius: 5)
                        .offset(x: -UIScreen.main.bounds.width * 0.35)
                        .padding(.top, UIScreen.main.bounds.height * 0.01)
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
                            
                            Image(self.deals_clicked == true ? categoryGlobal.selected_cat_names1[0] : categoryGlobal.cat_names1[0]).resizable().frame(width:40, height:40).padding()
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
                            
                            Image(self.happy_clicked == true ? categoryGlobal.selected_cat_names1[1] : categoryGlobal.cat_names1[1]).resizable().frame(width:40, height:40).padding()
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
                            
                            Image(self.rec_clicked == true ? categoryGlobal.selected_cat_names1[2] : categoryGlobal.cat_names1[2]).resizable().frame(width:40, height:40).padding()
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
                            
                            Image(self.what_clicked == true ? categoryGlobal.selected_cat_names1[3] : categoryGlobal.cat_names1[3]).resizable().frame(width:40, height:40).padding()
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
                            Image(self.misc_clicked == true ? categoryGlobal.selected_cat_names1[4] : categoryGlobal.cat_names1[4]).resizable().frame(width:40, height:40).padding()
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
                    .padding(.bottom, UIScreen.main.bounds.height * 0.01)
                }
                if #available(iOS 14.0, *)
                {
                    Text("Where").font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                        .shadow(color: .white, radius: 5)
                        .offset(x: -UIScreen.main.bounds.width * 0.35)
                    TextEditor(text: self.$post_title)
                        .padding()
                        
                        
                        .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.9, minHeight: 50, maxHeight: 65)
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
                        .padding(.bottom, UIScreen.main.bounds.height * 0.01)
                    
                    
                    
                    Text("Content").font(.headline)
                        .fontWeight(.bold)
                        .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                        .shadow(color: .white, radius: 5)
                        .offset(x: -UIScreen.main.bounds.width * 0.35)
                    
                    TextEditor(text: self.$post_content)
                        
                        .padding()
                        .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.9, minHeight: 100, maxHeight: 150)
                        
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
                            
                            if post_title.isEmpty || post_title == default_post_title
                            {
                                self.showingAlert = true
                                self.errorMessage = "Enter in value for Where"
                            }
                            
                            if post_content.isEmpty || post_content == default_post_content
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
                                self.post_title_pressed.toggle()
                                self.post_content_pressed.toggle()
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
                Spacer()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .edgesIgnoringSafeArea(.bottom)
            .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .onAppear
            {
                category_id = categoryGlobal.category_id
                if(categoryGlobal.category_id == 1)
                {
                    deals_clicked.toggle()
                }
                else if(categoryGlobal.category_id == 2)
                {
                    happy_clicked.toggle()
                }
                else if(categoryGlobal.category_id == 3)
                {
                    rec_clicked.toggle()
                }
                else if(categoryGlobal.category_id == 4)
                {
                    what_clicked.toggle()
                }
                else if(categoryGlobal.category_id == 5)
                {
                    misc_clicked.toggle()
                }
            }
            .onTapGesture {
                UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
                if self.post_title.isEmpty{
                    self.post_title = self.default_post_title
                    self.post_title_pressed.toggle()
                }
                if self.post_content.isEmpty{
                    self.post_content = self.default_post_content
                    self.post_content_pressed.toggle()
                }
            }
        } else {
            // Fallback on earlier versions
        }
        

        
        
    }
    
}

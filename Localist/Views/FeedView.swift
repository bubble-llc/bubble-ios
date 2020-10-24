//
//  FeedView.swift
//  Localist
//
//  Created by Steven Tran on 9/26/20.
//  Copyright © 2020 Localist. All rights reserved.
//

import SwiftUI
import Request

struct FeedView: View {
    @State private var sortBy: SortBy = .hot
    @State private var showSortSheet: Bool = false
    @State private var showSubmitPost: Bool = false
    @State private var showCreateUser: Bool = false
    @State private var post_content: String = ""
    
    @Binding var loggedIn: Bool
    @State var size = UIScreen.main.bounds.width / 1.6
    
    
    var body: some View
    {
        ZStack{
            PostList(type: "feed")
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle(Text("Feed"), displayMode: .inline)
                    .navigationBarItems(
                        leading: HStack
                        {
                            Button(action: {self.size = 10}, label: {
                                
                                Image(systemName: "gearshape.fill").resizable().frame(width: 20, height: 20)
                            }).foregroundColor(.black)
                            if loggedIn{
                            NavigationLink(destination: SubmitPostView(), isActive: $showSubmitPost)
                            {
                                EmptyView()
                            }
                        }
                            else{
                                NavigationLink(destination: LoginView(loggedIn: self.$loggedIn), isActive: $showSubmitPost)
                                {
                                    EmptyView()
                                }
                            }
                        },
                        trailing: HStack
                        {
                            if loggedIn
                            {
                                Button(action: {self.showSubmitPost.toggle()})
                                {
                                    Image(systemName: "plus")
                                }
                            }
                            else
                            {
                                NavigationLink(destination: LoginView(loggedIn: self.$loggedIn))
                                {
                                    Text("Login")
                                }
                            }
                        }
                    )
//                    .actionSheet(isPresented: $showSortSheet)
//                    {
//                        ActionSheet(title: Text("Sort By:"), buttons: [SortBy.hot,SortBy.new, ].map
//                            { method in
//                                ActionSheet.Button.default(Text(method.rawValue.prefix(1).uppercased() + method.rawValue.dropFirst()))
//                                {
//                                    self.sortBy = method
//                                }
//                            }
//                        )
//                    }
            
            
            HStack{
                menu(size: $size, loggedIn: self.$loggedIn)
                .cornerRadius(20)
                    .padding(.leading, -size)
                    .offset(x: -size)
                
                Spacer()
            }
        }.animation(.spring())
    }
}

//struct FeedView_Previews: PreviewProvider {
//    static var previews: some View {
//        FeedView()
//    }
//}

struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    var onDone: (() -> Void)?

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator
        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false
        textField.backgroundColor = UIColor.clear
        
        if nil != onDone {
            textField.returnKeyType = .done
        }

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        
        return textField
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        
        if uiView.window != nil, !uiView.isFirstResponder {
            uiView.becomeFirstResponder()
        }
        
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }

    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>)
    {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        
        if result.wrappedValue != newSize.height
        {
            DispatchQueue.main.async
            {
                result.wrappedValue = newSize.height // !! must be called asynchronously
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, onDone: onDone)
    }

    final class Coordinator: NSObject, UITextViewDelegate
    {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?

        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil)
        {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
        }

        func textViewDidChange(_ uiView: UITextView)
        {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
        {
            if let onDone = self.onDone, text == "\n"
            {
                textView.resignFirstResponder()
                onDone()
                return false
            }
            return true
        }
    }
}

struct MultilineTextField: View {
    @State private var dynamicHeight: CGFloat = 100
    @State private var showingPlaceholder = false
    
    private var placeholder: String
    private var onCommit: (() -> Void)?

    @Binding private var text: String
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.showingPlaceholder = $0.isEmpty
        }
    }

    init (_ placeholder: String = "", text: Binding<String>, onCommit: (() -> Void)? = nil) {
        self.placeholder = placeholder
        self.onCommit = onCommit
        self._text = text
        self._showingPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
    }

    var body: some View {
        UITextViewWrapper(text: self.internalText, calculatedHeight: $dynamicHeight, onDone: onCommit)
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
            .background(placeholderView, alignment: .topLeading)
    }

    var placeholderView: some View
    {
        Group
        {
            if showingPlaceholder
            {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }
}

struct menu : View {
    @Binding var size : CGFloat
    @Binding var loggedIn: Bool

    var body : some
    View{
        VStack
        {
            HStack
            {
                Spacer()
                Button(action:
                {
                    self.size =  UIScreen.main.bounds.width / 1.6
                })
                {
                    // Change image to look like an exit
                    Image(systemName: "house.fill").resizable().frame(width: 15, height: 15).padding()
                }.background(Color.red)
                    .foregroundColor(.white)
                .clipShape(Circle())
            }
            
            HStack
            {
                Button(action: goHome)
                {
                    Image(systemName: "house.fill").resizable().frame(width: 25, height: 25).padding()
                    Text("Home").fontWeight(.heavy)
                }
                Spacer()
            }.padding(.leading, 20)
            if loggedIn{
            HStack
            {
                Button(action: goProfile)
                {
                    Image(systemName: "person.fill").resizable().frame(width: 25, height: 25).padding()
                    Text("Account").fontWeight(.heavy)
                }
                Spacer()
            }.padding(.leading, 20)
            
            HStack
            {
                Button(action: goLiked)
                {
                    Image(systemName: "checkmark.rectangle.fill").resizable().frame(width: 25, height: 25).padding()
                    Text("Liked").fontWeight(.heavy)
                }
                Spacer()
            }.padding(.leading, 20)
            
            Spacer()
            
            HStack
            {
                Button(action: goExit)
                {
                    Image(systemName: "paperplane.fill").resizable().frame(width: 25, height: 25).padding()
                    Text("Exit").fontWeight(.heavy)
                }
                Spacer()
            }.padding(.leading, 20)
            
            }
            else{
                HStack
                {
                    NavigationLink(destination:CreateUserView())
                    {
                        Image(systemName: "person.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Create Account").fontWeight(.heavy)
                    }
                    Spacer()
                }.padding(.leading, 20)
                Spacer()
            }
        }.frame(width: UIScreen.main.bounds.width / 1.6)
            .background(Color.white)
        
    }
    
    func goHome() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ContentView())
            window.makeKeyAndVisible()
        }
    }
    
    func goProfile() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: UserProfileView(loggedIn: self.$loggedIn))
            window.makeKeyAndVisible()
        }
    }
    
    func goLiked() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: UserLikedView(loggedIn: self.$loggedIn))
            window.makeKeyAndVisible()
        }
    }
    
    
    func goExit() {
        let defaults = UserDefaults.standard
        defaults.set("username", forKey: defaultsKeys.username)
        defaults.set("password", forKey: defaultsKeys.password)
        
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ContentView())
            window.makeKeyAndVisible()
        }
    }
}


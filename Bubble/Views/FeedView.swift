//
//  FeedView.swift
//  Localist
//
//  Created by Steven Tran on 9/26/20.
//  Copyright © 2020 Localist. All rights reserved.
//

import SwiftUI
import Request
import SlideOverCard

struct FeedView: View {
    @State private var sortBy: SortBy = .hot
    @State private var showSortSheet: Bool = false
    @State private var showSubmitPost: Bool = false
    @State private var showCreateUser: Bool = false
    @State private var post_content: String = ""
    @State private var position = CardPosition.bottom
    @State private var isMenu: Bool = false
    
    @Binding var userLatitude: String
    @Binding var userLongitude: String
    @Binding var category: String
    
    @EnvironmentObject var userAuth: UserAuth
    
    var body: some View
    {
        let drag = DragGesture()
            .onEnded{
                if $0.translation.width < -100 {
                                    withAnimation {
                                        self.isMenu = false
                                    }
                                }
            }
        ZStack{
            PostList(type: "feed", userLatitude: self.$userLatitude , userLongitude: self.$userLongitude, category: self.$category)
                    .navigationBarBackButtonHidden(true)
                    .navigationBarTitle(Text("Feed"), displayMode: .inline)
                    .navigationBarItems(
                        leading: HStack
                        {
                            Button(action: {
                                
                                withAnimation{
                                    self.isMenu.toggle()
                                }
                                
//                                print(category)
//                                if self.isMenu == false
//                                {
//                                    self.position = CardPosition.top
//                                    self.isMenu = true
//                                }
//                                else
//                                {
//                                    self.position = CardPosition.bottom
//                                    self.isMenu = false
//                                }
                                
                            }, label: {
                                Image(systemName: "line.horizontal.3")
                            })
                        },
                        trailing: HStack
                        {
                        }
                    )
            if self.isMenu{
                GeometryReader { geometry in
            menu(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude, position: self.$position)
                .frame(width: geometry.size.width/2)
                .transition(.move(edge: .leading))
                .environmentObject(userAuth)
                }
            }

        }.animation(.spring())
    }
    
}



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
    @Binding var userLatitude: String
    @Binding var userLongitude: String
    @Binding var position: CardPosition
    
    @State private var background = BackgroundStyle.solid
    
    @EnvironmentObject var userAuth: UserAuth

    var body : some
    View{
            VStack
            {
                HStack
                {
                    NavigationLink(destination: UserProfileView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude))
                    {
                        Image(systemName: "person.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Account").fontWeight(.heavy)
                    }
                    Spacer()
                }

                HStack
                {
                    NavigationLink(destination: UserLikedView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude))
                    {
                        Image(systemName: "checkmark.rectangle.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Liked").fontWeight(.heavy)
                    }
                    Spacer()
                }
                    
                    
                HStack
                {
                    NavigationLink(destination: ReportView())
                    {
                        Image(systemName: "envelope.open.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Report Issue").fontWeight(.heavy)
                    }
                        
                    
                    Spacer()
                }
                    
                HStack
                {
                    Button(action: goExit)
                    {
                        Image(systemName: "paperplane.fill").resizable().frame(width: 25, height: 25).padding()
                        Text("Exit").fontWeight(.heavy)
                    }
                    Spacer()
                }
            }.frame(maxWidth: .infinity, alignment: .leading)
//            .background(Color(red: 45/255, green: 45/255, blue: 45/255))
            .background(Color.black.opacity(0.8))
            .edgesIgnoringSafeArea(.all)
        
    }
        
    func goProfile() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: UserProfileView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude))
            window.makeKeyAndVisible()
        }
    }
    
    func goLiked() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: UserLikedView(userLatitude: self.$userLatitude , userLongitude: self.$userLongitude))
            window.makeKeyAndVisible()
        }
    }
    
    func goReport() {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = UIHostingController(rootView: ReportView())
            window.makeKeyAndVisible()
        }
    }
    func goExit() {
        let defaults = UserDefaults.standard
        defaults.set("username", forKey: defaultsKeys.username)
        defaults.set("password", forKey: defaultsKeys.password)
        userAuth.isLoggedin = false
    }
}


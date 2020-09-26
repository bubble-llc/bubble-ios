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
    @State private var subreddit: String = "swift"
    @State private var sortBy: SortBy = .hot
    
    
    
    @State private var showSortSheet: Bool = false
    @State private var showSubredditSheet: Bool = false
    @State private var showCreateUser: Bool = false
    
    @State private var post_content: String = ""
    var body: some View {
        NavigationView {
            /// Load the posts
            PostList()
                /// Force inline `NavigationBar`
                .navigationBarTitle(Text(""), displayMode: .inline)
                .navigationBarItems(
                    leading: HStack {
                        Button(action: {self.showSubredditSheet.toggle()})
                        {
                            //This is where the submit button logic will go
                            Text("New Post")
                        }
                    },
                    trailing: HStack {
                        Button(action: {self.showSortSheet.toggle()})
                        {
                            HStack {
                                Image(systemName: "arrow.up.arrow.down")
                                Text(self.sortBy.rawValue)
                            }
                        }

                    }
                )
                /// Sorting method `ActionSheet`
                .actionSheet(isPresented: $showSortSheet) {
                    ActionSheet(title: Text("Sort By:"), buttons: [SortBy.hot,SortBy.new, ].map { method in
                        ActionSheet.Button.default(Text(method.rawValue.prefix(1).uppercased() + method.rawValue.dropFirst())) {
                            self.sortBy = method
                        }
                    })
                }
                /// Submit a post
                .popover(isPresented: $showSubredditSheet) {
                    VStack() {
                        
                        Text("What's going on?")
                        if #available(iOS 14.0, *)
                        {
                            TextEditor(text: self.$post_content)
                                .padding()
                                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 350)
                                .border(Color.black, width:1)
                        }
                        else
                        {
                            // Fallback on earlier versions
                            MultilineTextField("Enter post here...", text: self.$post_content)
                                .padding(3)
                                .frame(minWidth: 100, idealWidth: 100/*@END_MENU_TOKEN@*/, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center)
                                .background(RoundedRectangle(cornerRadius:5))
                        }
                        
                        Button(action: {
                            //                        self.post_content = "nice"
                            let postObject: [String: Any]  =
                                [
                                    "username": "steventt07",
                                    "category_name": "What's happening?",
                                    "content": self.post_content,
                                    "title": "Testing Post Feed",
                                    "zipcode": "78703"
                                ]
                            API().submitPost(submitted: postObject)
                        })
                        {
                            //This is where the submit button logic will go
                            Text("Submit")
                        }
                    }
                    .frame(width: 200)
                    .padding()
                    .background(Color("green"))
                    .cornerRadius(10)
                }
            Text("Select a post")
        }
    }
}

struct FeedView_Previews: PreviewProvider {
    static var previews: some View {
        FeedView()
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

    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // !! must be called asynchronously
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, onDone: onDone)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?

        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
        }

        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onDone = self.onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return false
            }
            return true
        }
    }

}

struct MultilineTextField: View {

    private var placeholder: String
    private var onCommit: (() -> Void)?

    @Binding private var text: String
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.showingPlaceholder = $0.isEmpty
        }
    }

    @State private var dynamicHeight: CGFloat = 100
    @State private var showingPlaceholder = false

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

    var placeholderView: some View {
        Group {
            if showingPlaceholder {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }
}


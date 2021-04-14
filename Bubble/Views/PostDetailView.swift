import SwiftUI
import Request
import SwiftUIRefresh
import Combine

struct KeyboardResponsiveModifier: ViewModifier {
  @State private var offset: CGFloat = 0

  func body(content: Content) -> some View {
    content
      .padding(.bottom, offset)
      .onAppear {
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { notif in
          let value = notif.userInfo![UIResponder.keyboardFrameEndUserInfoKey] as! CGRect
          let height = value.height + UIScreen.main.bounds.width * 0.05
          let bottomInset = UIApplication.shared.windows.first?.safeAreaInsets.bottom
          self.offset = height - (bottomInset ?? 0)
        }

        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { notif in
          self.offset = 0
        }
    }
  }
}

extension View {
  func keyboardResponsive() -> ModifiedContent<Self, KeyboardResponsiveModifier> {
    return modifier(KeyboardResponsiveModifier())
  }
}

struct PostDetailView: View {
    let post: Post
    
    @Binding var isUp: Bool
    @Binding var isDown: Bool
    @Binding var totalVotes: Int
    @Binding var upColor: Color
    @Binding var downColor: Color
    @Binding var isVoted: Bool
    @Binding var upVotesOnly: Bool
    @Binding var downVotesOnly: Bool
    
    @State private var isShowing = false
    @State var comments: [Comment] = []
    @State private var commentBoxPressed: Bool = false
    @State private var default_comment: String = "Enter comment here..."
    @State private var placeholder_default_comment: String = "Enter comment here..."
    @State private var showingAlert = false
    
    
    @EnvironmentObject var categoryGlobal: Category
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        if #available(iOS 14.0, *) {
            VStack(alignment: .leading)
            {
                //Post title. The Frame indicatew where it will be aligned, font adjusts text size
                HStack{
                    Spacer()
                    Text(post.title)
                        .bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                        .font(.system(size:30))
                        .offset(x:10)
                    Spacer()
                    MetadataView(post: post,
                                 isUp: self.$isUp,
                                 isDown: self.$isDown,
                                 totalVotes: self.$totalVotes,
                                 upColor: self.$upColor,
                                 downColor: self.$downColor,
                                 isVoted: self.$isVoted,
                                 upVotesOnly: self.$upVotesOnly,
                                 downVotesOnly: self.$downVotesOnly)
                        .padding(.top)
                        .padding(.trailing, 10)
                    Spacer()
                    
                }.foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                //Built in function for adding spaces in V/H Stacks
                Spacer()
                
                //If it IS empty it should not be valid in the first place. Need to figure out how to rework this
                Text(post.content)
                    .padding()
                    .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.95, minHeight: UIScreen.main.bounds.height * 0.1)
                    .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                    .background(Color(red: 171 / 255, green: 233 / 255, blue: 255 / 255))
                    .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255), lineWidth: 2)
                    )
                    .padding(.leading, UIScreen.main.bounds.width * 0.025)
                
                VStack{
                    if #available(iOS 14.0, *) {
                        List(comments){ comment in
                            CommentsView(comment: comment)
                            
                        }
                        .colorMultiply(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                        .onAppear{
                            API().getComment(post_id: post.id) { (comments) in
                                self.comments = comments
                            }
                        }
                        .pullToRefresh(isShowing: $isShowing) {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                API().getComment(post_id: post.id) { (comments) in
                                    self.comments = comments
                                }
                                self.isShowing = false
                            }
                        }.onChange(of: self.isShowing){value in
                            //categoryGlobal.fetchData()
                            // print("oops")
                            // categoryGlobal.refreshCategory(category: categoryGlobal.currCategory)
                        }
                    } else {
                        // Fallback on earlier versions
                    }
                }
                //Removed spacing from MetadataView in this context to keep it centered rather than offset on the right side.
                
                HStack{
                    if #available(iOS 14.0, *)
                    {
                        //We are currently allowing there to be trailing spaces after comments, need to auto remove those from the comment
                        //object before we actually let it be submitted
                        TextEditor(text: self.$default_comment)
                            
                            .onTapGesture {
                                if !self.commentBoxPressed{
                                    self.default_comment = ""
                                    self.commentBoxPressed = true
                                }
                            }
                            
                            .multilineTextAlignment(.leading)
                            
                            .frame(minWidth: UIScreen.main.bounds.width * 0.75, maxWidth: UIScreen.main.bounds.width * 0.9, minHeight: UIScreen.main.bounds.height * 0.01, maxHeight: UIScreen.main.bounds.height * 0.08)
                            .padding(5)
                            .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                            
                            .colorMultiply(Color(red: 171 / 255, green: 233 / 255, blue: 255 / 255))
                            .background(Color(red: 171 / 255, green: 233 / 255, blue: 255 / 255))
                            .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255), lineWidth: 2)
                            )
                            .padding(.top, 2)
                        
                    }
                    Spacer()
                    Button(action:
                            {
                                let resign = #selector(UIResponder.resignFirstResponder)
                                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
                                self.showingAlert.toggle()
                                
                            })
                    {
                        Image(systemName:"mail")
                        
                    }
                    .alert(isPresented:$showingAlert){
                        
                        Alert(title: Text("Submit comment?"),
                              message: Text(""),
                              primaryButton: .default(Text("Submit")){
                                
                                
                                
                                    let defaults = UserDefaults.standard
                                    let user_id = defaults.string(forKey: defaultsKeys.user_id)!
                                    let commentObject: [String: Any]  =
                                        [
                                            "post_id": post.id,
                                            "user_id": user_id,
                                            "content": self.default_comment,
                                        ]
                                    DispatchQueue.main.asyncAfter(deadline: .now()) {
                                        API().submitComment(submitted: commentObject)
                                        self.default_comment = self.placeholder_default_comment
                                    }
                                
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    API().getComment(post_id: post.id) { (comments) in
                                        self.comments = comments
                                    }
                                }
                                self.commentBoxPressed.toggle()
                              },
                              secondaryButton: .cancel())
                    }
                    .disabled(self.default_comment == self.placeholder_default_comment || self.default_comment.isEmpty)
                    Spacer()
                }.padding(.leading, UIScreen.main.bounds.width * 0.025)
                .padding(.bottom, UIScreen.main.bounds.width * 0.05)
                Spacer()
            }
            .keyboardResponsive()
            .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .onAppear(){
                UITableView.appearance().backgroundColor = .clear
                UITableViewCell.appearance().backgroundColor = .clear
            }
            
            .edgesIgnoringSafeArea(.bottom)
        } else {
            // Fallback on earlier versions
        }
            
    }
}

struct FooterView: View {
    @State private var comment_content: String = ""
    @State private var placeholderString: String = "Add a comment"
    
    let post: Post
    
    var body: some View {
        MultilineTextField("Enter comment here...", text: self.$comment_content)
            .frame(maxWidth: .infinity, minHeight: 100)
        Button(action:
        {
            let defaults = UserDefaults.standard
            let user_id = defaults.string(forKey: defaultsKeys.user_id)!
            let commentObject: [String: Any]  =
                [
                    "post_id": post.id,
                    "user_id": user_id,
                    "content": self.comment_content,
                ]
            API().submitComment(submitted: commentObject)
            self.comment_content = ""
        })
        {
            Text("Submit")
        }
    }
}

public struct TextAlert {
  public var title: String // Title of the dialog
  public var message: String // Dialog message
  public var placeholder: String = "" // Placeholder text for the TextField
  public var accept: String = "OK" // The left-most button label
  public var cancel: String? = "Cancel" // The optional cancel (right-most) button label
  public var secondaryActionTitle: String? = nil // The optional center button label
  public var keyboardType: UIKeyboardType = .default // Keyboard tzpe of the TextField
  public var action: (String?) -> Void // Triggers when either of the two buttons closes the dialog
  public var secondaryAction: (() -> Void)? = nil // Triggers when the optional center button is tapped
}

extension UIAlertController {
  convenience init(alert: TextAlert) {
    self.init(title: alert.title, message: alert.message, preferredStyle: .alert)
    addTextField {
       $0.placeholder = alert.placeholder
       $0.keyboardType = alert.keyboardType
    }
    if let cancel = alert.cancel {
      addAction(UIAlertAction(title: cancel, style: .cancel) { _ in
        alert.action(nil)
      })
    }
    if let secondaryActionTitle = alert.secondaryActionTitle {
       addAction(UIAlertAction(title: secondaryActionTitle, style: .default, handler: { _ in
         alert.secondaryAction?()
       }))
    }
    let textField = self.textFields?.first
    addAction(UIAlertAction(title: alert.accept, style: .default) { _ in
      alert.action(textField?.text)
    })
  }
}

struct AlertWrapper<Content: View>: UIViewControllerRepresentable {
  @Binding var isPresented: Bool
  let alert: TextAlert
  let content: Content

  func makeUIViewController(context: UIViewControllerRepresentableContext<AlertWrapper>) -> UIHostingController<Content> {
    UIHostingController(rootView: content)
  }

  final class Coordinator {
    var alertController: UIAlertController?
    init(_ controller: UIAlertController? = nil) {
       self.alertController = controller
    }
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator()
  }

  func updateUIViewController(_ uiViewController: UIHostingController<Content>, context: UIViewControllerRepresentableContext<AlertWrapper>) {
    uiViewController.rootView = content
    if isPresented && uiViewController.presentedViewController == nil {
      var alert = self.alert
      alert.action = {
        self.isPresented = false
        self.alert.action($0)
      }
      context.coordinator.alertController = UIAlertController(alert: alert)
      uiViewController.present(context.coordinator.alertController!, animated: true)
    }
    if !isPresented && uiViewController.presentedViewController == context.coordinator.alertController {
      uiViewController.dismiss(animated: true)
    }
  }
}

extension View {
  public func alert(isPresented: Binding<Bool>, _ alert: TextAlert) -> some View {
    AlertWrapper(isPresented: isPresented, alert: alert, content: self)
  }
}

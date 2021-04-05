import SwiftUI
import Request

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
    
    @State var comments: [Comment] = []
    
    
    var body: some View {
            VStack
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
                    .frame(minWidth: 0, maxWidth: UIScreen.main.bounds.width * 0.9, minHeight: UIScreen.main.bounds.height * 0.1)
                    .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                    .background(Color(red: 171 / 255, green: 233 / 255, blue: 255 / 255))
                    .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                    .cornerRadius(25)
                    .overlay(
                        RoundedRectangle(cornerRadius: 25)
                            .stroke(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255), lineWidth: 2)
                    )
                
              
                //Removed spacing from MetadataView in this context to keep it centered rather than offset on the right side.

                Spacer()
                NavigationLink(destination: SubmitCommentView(post:post)){
                    Text("Add Comment")
                        .fontWeight(.bold)
                        .padding(8)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                        .background(Color(red: 171 / 255, green: 233 / 255, blue: 255 / 255))
                        .cornerRadius(8)
                        .foregroundColor(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255))
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color(red: 43 / 255, green: 149 / 255, blue: 173 / 255), lineWidth: 2)
                        )
                }
                VStack{
                List(comments){ comment in
                    CommentsView(comment: comment)

                }
                .colorMultiply(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
                .onAppear{
                    API().getComment(post_id: post.id) { (comments) in
                        self.comments = comments
                    }
                }
                }
            }
            .listRowBackground(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
            .background(Color(red: 112 / 255, green: 202 / 255, blue: 211 / 255))
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

import SwiftUI
import Request

struct PostDetailView: View {
    let post: Post
    
    var title: some View {
        let vstack = VStack(alignment: .leading) {

            Text(post.title)
                .bold()
        }

        return vstack

    }
    
    var body: some View {
        let list = List {


            // Body
            // Body
            title
            if post.content != "" {
                Text(post.content)
            }

            MetadataView(post: post, spaced: true)
            
        }

        return list.navigationBarTitle(Text("Localist"), displayMode: .inline)

    }
}

//#if DEBUG
//struct PostDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PostDetailView(post: Post.title)
//    }
//}
//#endif

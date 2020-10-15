import SwiftUI
import Request

struct PostView: View
{
    let post: Post
    
    var body: some View
    {
        VStack(alignment: .leading)
        {
            Text(post.title)
                .font(.headline)
                .lineLimit(1)
            Group
            {
                Text(post.content)
            }
            MetadataView(post: post)
                .font(.caption)
        }
    }
}

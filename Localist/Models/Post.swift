

import Foundation

struct Post: Decodable, Identifiable {
    let title: String
    let id = UUID()
    /// The body of the post
    let content: String
    let username: String

}

//Stevens DB:
//post_id = Int
//username = String
//category_name = String
//content = String
//comments = String
//votes = Int
//zipcode = String
//date_created = Whatever the fuck the time object is called

//struct Post: Decodable, Identifiable {
//    let username: String
//    let post_id: Int
//    /// The body of the post
//    let content: String
//    let username: String
//    zipcode: String
//    category_name: String
//
//}

//#if DEBUG
//extension Post {
//    /// Used to create a Post for example Debug purposes
//    static var example: Self {
//        return Post(title: "Hello World | This is secondary text", id: 1, body: "This is some body content. Blah blah\nblah blah blah", userId:1)
//    }
//}
//#endif

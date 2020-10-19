import Foundation

struct Post: Decodable, Identifiable {
    let title: String
    let id: String
    let content: String
    let username: String
    let zipcode: String
    let date_created: String
    let comments: Int
    let votes: Int
    let category_name: String
    let is_voted: Bool
    let prev_vote: Int
}

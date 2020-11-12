import Foundation

struct Post: Decodable, Identifiable {
    let title: String
    let id: String
    let content: String
    let username: String
    let date_created: String
    let comments: Int
    let votes: Int
    let category_name: String
    let is_voted: Bool
    let prev_vote: Int
    let latitude: Double
    let longitude: Double
    
    private enum CodingKeys: String, CodingKey {
            case title, id, content, username, date_created, comments, votes, category_name, is_voted, prev_vote, latitude, longitude, date
        }
    
    init(from decoder: Decoder) throws
    {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        title = try values.decode(String.self, forKey: .title)
        id = try values.decode(String.self, forKey: .id)
        content = try values.decode(String.self, forKey: .content)
        username = try values.decode(String.self, forKey: .username)
        date_created = convert_date(try values.decode(String.self, forKey: .date_created))
        comments = try values.decode(Int.self, forKey: .comments)
        votes = try values.decode(Int.self, forKey: .votes)
        category_name = try values.decode(String.self, forKey: .category_name)
        is_voted = try values.decode(Bool.self, forKey: .is_voted)
        prev_vote = try values.decode(Int.self, forKey: .prev_vote)
        latitude = try values.decode(Double.self, forKey: .latitude)
        longitude = try values.decode(Double.self, forKey: .longitude)
    }
}

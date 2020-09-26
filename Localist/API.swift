import Foundation

class API {
    func getPosts(completion: @escaping ([Post]) ->()){
        guard let url = URL(string: "https://dashboard.stocksandshare.com/chitchat/feed?zipcode=78703&username=johnDoe") else {return}
        URLSession.shared.dataTask(with: url){ (data,_,_)in
            let posts = try! JSONDecoder().decode([Post].self, from:data!)
            DispatchQueue.main.async{
                completion(posts)
            }
            
            
        }
    .resume()
    }
    
    func submitPost(submitted: [String: Any]){
        guard let postUrl = URL(string: "https://dashboard.stocksandshare.com/chitchat/add_post_to_category") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let submission = try? JSONSerialization.data(withJSONObject: submitted)
        
        request.httpBody = submission
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
        
        
        

        
            //postString = submitted
        
//        request.httpBody = postString(using: String.Encoding.utf8)
//
//        let task = URLSession.shared.dataTask(with: request){ (data, response, error) in
//
//            if let error = error{
//                print("Error took place \(error)")
//                return
//            }
//
//            if let data = data, let dataString = String(data: data, encoding: .utf8){
//                print("Response data string:\n \(dataString)")
//            }
//
//
//
//        }
//        task.resume()
        
    }
    
    func createUser(submitted: [String: Any]){
        guard let postUrl = URL(string: "https://dashboard.stocksandshare.com/chitchat/user") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
        let submission = try? JSONSerialization.data(withJSONObject: submitted, options: .prettyPrinted)
        
        request.httpBody = submission

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any] {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
}


//curl --location --request POST 'http://0.0.0.0:8000/add_post_to_category' \
//--header 'Content-Type: application/json' \
//--data-raw '{
//    "username": "steventt07",
//    "category_name": "What'\''s happening?",
//    "content": "My thirs post",
//    "title": "Lalala",
//    "zipcode": "78703"
//}'

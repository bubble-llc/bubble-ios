import Foundation

class API {
    let baseURL = "https://dashboard.stocksandshare.com/chitchat"
    //let baseURL = "http://0.0.0.0:8000"
    func getPosts(completion: @escaping ([Post]) ->()){
        guard let url = URL(string: "\(baseURL)/feed?zipcode=78703&username=johnDoe") else {return}
        URLSession.shared.dataTask(with: url){ (data,_,_)in
            let posts = try! JSONDecoder().decode([Post].self, from:data!)
            DispatchQueue.main.async{
                completion(posts)
            }
            
            
        }
    .resume()
    }
    
    func submitPost(submitted: [String: Any]){
        guard let postUrl = URL(string: "\(baseURL)/add_post_to_category") else {fatalError()}
        
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
        guard let postUrl = URL(string: "\(baseURL)/user") else {fatalError()}
        
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
    
    func validateUser(username: String, password: String) -> Bool{
        guard let postUrl = URL(string: "\(baseURL)/user?username=\(username)&password=\(password )") else {fatalError()}
        var result: Result<String?, NetworkError>!
        var validUser = false
        let semaphore = DispatchSemaphore(value: 0)
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                result = .success(String(data: data, encoding: .utf8))
            } else {
                result = .failure(.server)
            }
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
        switch result {
            case let .success(data):
                let user = convertStringToDictionary(text: data!)?["user"]
                let userData = user?.count
                if userData! == 1
                {
                    validUser = true
                }
                print(userData!)
            case let .failure(error):
                print(error)
            case .none:
                print("errpr")
            }

        return validUser
    }
}

func convertStringToDictionary(text: String) -> [String:AnyObject]? {
    if let data = text.data(using: .utf8) {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
            return json
        } catch {
            print("Something went wrong")
        }
    }
    return nil
}

extension URLResponse {

    func getStatusCode() -> Int? {
        if let httpResponse = self as? HTTPURLResponse {
            return httpResponse.statusCode
        }
        return nil
    }
}

enum NetworkError: Error {
    case url
    case server
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

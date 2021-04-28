import Foundation

class API {
    let baseURL = "https://dashboard.stocksandshare.com/chitchat"
//    let baseURL = "http://0.0.0.0:8000"
    let categories = ["Deals":1, "Happy Hour":2, "Recreation":3, "What's Happening?":4, "Misc":5]
    
    func getPosts(logitude: String, latitude: String, category: String, completion: @escaping ([Post]) ->()){
        let defaults = UserDefaults.standard
        let user_id = defaults.string(forKey: defaultsKeys.user_id)!
        var paramStr = ""
        paramStr += "user_id=\(String(describing: user_id))&"
        paramStr += "category_id=\(String(describing: categories[category]! ))"
        
        guard let url = URL(string: "\(baseURL)/category?\(String(describing: paramStr))") else {return}
        URLSession.shared.dataTask(with: url)
        { (data,_,_) in
            
            let posts = try! JSONDecoder().decode([Post].self, from: data!)
            DispatchQueue.main.async
            {
                completion(posts)
            }
        }.resume()
    }
    
    func getUserCreatedPosts(completion: @escaping ([Post]) ->()){
         let defaults = UserDefaults.standard
         let user_id = defaults.string(forKey: defaultsKeys.user_id)!

         guard let url = URL(string: "\(baseURL)/user_created_post?user_id=\(String(describing: user_id))") else {return}
         URLSession.shared.dataTask(with: url)
         { (data,_,_) in

             let posts = try! JSONDecoder().decode([Post].self, from:data!)
             DispatchQueue.main.async
             {
                 completion(posts)
             }
         }.resume()
     }
    
    func getUserLikedPosts(completion: @escaping ([Post]) ->()){
         let defaults = UserDefaults.standard
         let user_id = defaults.string(forKey: defaultsKeys.user_id)!

         guard let url = URL(string: "\(baseURL)/user_liked_post?user_id=\(String(describing: user_id))") else {return}
         URLSession.shared.dataTask(with: url)
         { (data,_,_) in

             let posts = try! JSONDecoder().decode([Post].self, from:data!)
             DispatchQueue.main.async
             {
                 completion(posts)
             }
         }.resume()
     }
    
    func submitPost(submitted: [String: Any]){
        guard let postUrl = URL(string: "\(baseURL)/add_post_to_category") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        
        let submission = try? JSONSerialization.data(withJSONObject: submitted)
        
        request.httpBody = submission
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any]
            {
                print(responseJSON)
            }
        }
        task.resume()
    }
        
    func submitComment(submitted: [String: Any])
    {
        guard let postUrl = URL(string: "\(baseURL)/comment") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        
        let submission = try? JSONSerialization.data(withJSONObject: submitted)
        
        request.httpBody = submission
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any]
            {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    func submitVote(submitted: [String: Any])
    {
        guard let postUrl = URL(string: "\(baseURL)/vote") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        
        let submission = try? JSONSerialization.data(withJSONObject: submitted)
        
        request.httpBody = submission
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any]
            {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    func submitFeedback(submitted: [String: Any])
    {
        guard let postUrl = URL(string: "\(baseURL)/feedback") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        
        let submission = try? JSONSerialization.data(withJSONObject: submitted)
        
        request.httpBody = submission
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any]
            {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    func submitReportedPost(submitted: [String: Any])
    {
        guard let postUrl = URL(string: "\(baseURL)/report_post") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        
        let submission = try? JSONSerialization.data(withJSONObject: submitted)
        
        request.httpBody = submission
        
        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any]
            {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    func getComment(post_id: Int, completion: @escaping ([Comment]) ->())
    {
        let defaults = UserDefaults.standard
        let user_id = defaults.string(forKey: defaultsKeys.user_id)!
        guard let url = URL(string: "\(baseURL)/comment?user_id=\(user_id)&post_id=\(post_id)") else {return}
        URLSession.shared.dataTask(with: url)
        { (data,_,_)in
            
            let comments = try! JSONDecoder().decode([Comment].self, from:data!)
            DispatchQueue.main.async
            {
                completion(comments)
            }
            
            
        }.resume()
    }

    func createUser(submitted: [String: Any])
    {
        guard let postUrl = URL(string: "\(baseURL)/user") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        
        let submission = try? JSONSerialization.data(withJSONObject: submitted, options: .prettyPrinted)
        
        request.httpBody = submission

        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any]
            {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    func getUser(username: String, password: String, completion: @escaping ([User]) ->())
    {
        guard let url = URL(string: "\(self.baseURL)/user?username=\(username)&password=\(password )") else {fatalError()}
        URLSession.shared.dataTask(with: url)
        { (data,_,_)in
            
            let user = try! JSONDecoder().decode([User].self, from:data!)
            DispatchQueue.main.async
            {
                completion(user)
            }
        }.resume()
    }
    
    func passwordReset(submitted: [String: Any])
    {
        guard let postUrl = URL(string: "\(baseURL)/password_reset") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        
        let submission = try? JSONSerialization.data(withJSONObject: submitted, options: .prettyPrinted)
        
        request.httpBody = submission

        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any]
            {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    func validatePasswordReset(submitted: [String: Any])
    {
        guard let postUrl = URL(string: "\(baseURL)/validate_password_reset") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        
        let submission = try? JSONSerialization.data(withJSONObject: submitted, options: .prettyPrinted)
        
        request.httpBody = submission

        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any]
            {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
    func setDefaultCategory(submitted: [String: Any])
    {
        guard let postUrl = URL(string: "\(baseURL)/set_default_category") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        
        let submission = try? JSONSerialization.data(withJSONObject: submitted, options: .prettyPrinted)
        
        request.httpBody = submission

        let task = URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            guard let data = data, error == nil else
            {
                print(error?.localizedDescription ?? "No data")
                return
            }
            let responseJSON = try? JSONSerialization.jsonObject(with: data, options: [])
            if let responseJSON = responseJSON as? [String: Any]
            {
                print(responseJSON)
            }
        }
        task.resume()
    }
    
}

func convertStringToDictionary(text: String) -> [String:AnyObject]?
{
    if let data = text.data(using: .utf8)
    {
        do {
            let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:AnyObject]
            return json
        }
        catch
        {
            print("Something went wrong")
        }
    }
    return nil
}

extension URLResponse
{
    func getStatusCode() -> Int?
    {
        if let httpResponse = self as? HTTPURLResponse
        {
            return httpResponse.statusCode
        }
        return nil
    }
}

enum NetworkError: Error
{
    case url
    case server
}

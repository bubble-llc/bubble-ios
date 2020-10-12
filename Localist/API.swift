import Foundation

class API {
    //let baseURL = "https://dashboard.stocksandshare.com/chitchat"
    let baseURL = "http://0.0.0.0:8000"
    
    func getPosts(completion: @escaping ([Post]) ->()){
        let defaults = UserDefaults.standard
        let username = defaults.string(forKey: defaultsKeys.keyOne)!
        
        guard let url = URL(string: "\(baseURL)/feed?zipcode=78703&username=\(String(describing: username))") else {return}
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
        request.allHTTPHeaderFields =
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
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
        request.allHTTPHeaderFields =
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
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
    
    func getComment(post_id: String, completion: @escaping ([Comment]) ->())
    {
        guard let url = URL(string: "\(baseURL)/comment?post_id=\(post_id)") else {return}
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
        request.allHTTPHeaderFields =
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]
        
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
    
    func validateUser(username: String, password: String) -> Bool
    {
        guard let postUrl = URL(string: "\(baseURL)/user?username=\(username)&password=\(password )") else {fatalError()}
        
        var result: Result<String?, NetworkError>!
        var validUser = false
        var request = URLRequest(url: postUrl)
        
        let semaphore = DispatchSemaphore(value: 0)
        
        request.httpMethod = "GET"
        request.allHTTPHeaderFields =
        [
            "Content-Type": "application/json",
            "Accept": "application/json"
        ]

        URLSession.shared.dataTask(with: request)
        { data, response, error in
            
            if let data = data
            {
                result = .success(String(data: data, encoding: .utf8))
            }
            else
            {
                result = .failure(.server)
            }
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(wallTimeout: .distantFuture)
        switch result
        {
            case let .success(data):
                if data != ""
                {
                    let user = convertStringToDictionary(text: data!)?["user"]
                    let userData = user?.count
                    if userData! == 1
                    {
                        validUser = true
                        let defaults = UserDefaults.standard
                        defaults.set(username, forKey: defaultsKeys.keyOne)
                        defaults.set(password, forKey: defaultsKeys.keyTwo)
                    }
                }
            case let .failure(error):
                print(error)
            case .none:
                print("errpr")
        }
        return validUser
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

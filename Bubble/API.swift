import Foundation
import JWTDecode

class API {
    fileprivate let baseURL = "https://dashboard.stocksandshare.com/chitchat"
//    fileprivate let baseURL = "http://0.0.0.0:8000"
    let categories = ["Deals":1, "Happy Hour":2, "Recreation":3, "What's Happening?":4, "Misc":5]
    
    func getPosts(logitude: String, latitude: String, category: String, completion: @escaping (Result<[Post],Error>) ->())
    {
        var paramStr = ""
        paramStr += "token=\(String(describing: UserDefaults.standard.string(forKey: defaultsKeys.token)!))&"
        paramStr += "category_id=\(String(describing: categories[category]! ))"
        
        guard let url = URL(string: "\(baseURL)/category?\(String(describing: paramStr))") else {return}
        URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let response = response as? HTTPURLResponse else
            {
                print("API error: \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
            if let responseError = self.handleNetworkResponse(response: response)
            {
                completion(.failure(responseError))
                return
            }
            
            guard let validData = data, error == nil else {
                print("API error: \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
            let posts = try! JSONDecoder().decode([Post].self, from: validData)
            DispatchQueue.main.async
            {
                completion(.success(posts))
            }
        }.resume()
    }
    
    func getUserCreatedPosts(completion: @escaping (Result<[Post],Error>) ->())
    {
        guard let url = URL(string: "\(baseURL)/user_created_post?token=\(UserDefaults.standard.string(forKey: defaultsKeys.token)!)") else {return}
        URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let response = response as? HTTPURLResponse else
            {
                print("API error: \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
            if let responseError = self.handleNetworkResponse(response: response)
            {
                completion(.failure(responseError))
                return
            }

            guard let validData = data, error == nil else {
                print("API error: \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }

            let posts = try! JSONDecoder().decode([Post].self, from:validData)
            DispatchQueue.main.async
            {
                completion(.success(posts))
            }
        }.resume()
     }
    
    func getUserLikedPosts(completion: @escaping (Result<[Post],Error>) ->())
    {
        guard let url = URL(string: "\(baseURL)/user_liked_post?token=\(UserDefaults.standard.string(forKey: defaultsKeys.token)!)") else {return}
        URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
                print("API status: \(httpResponse.statusCode)")
            }
            
            guard let response = response as? HTTPURLResponse else
            {
                print("API error: \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
            if let responseError = self.handleNetworkResponse(response: response)
            {
                completion(.failure(responseError))
                return
            }

            guard let validData = data, error == nil else {
                print("API error: \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }

            let posts = try! JSONDecoder().decode([Post].self, from:validData)
            DispatchQueue.main.async
            {
                completion(.success(posts))
            }
        }.resume()
    }
    func getComment(post_id: Int, completion: @escaping (Result<[Comment],Error>) ->())
    {
        guard let url = URL(string: "\(baseURL)/comment?token=\(UserDefaults.standard.string(forKey: defaultsKeys.token)!)&post_id=\(post_id)") else {return}
        URLSession.shared.dataTask(with: url)
        { (data, response, error) in
            if let httpResponse = response as? HTTPURLResponse {
               print("API status: \(httpResponse.statusCode)")
            }
            
            guard let response = response as? HTTPURLResponse else
            {
                print("API error: \(error!.localizedDescription)")
                completion(.failure(error!))
                return
            }
            if let responseError = self.handleNetworkResponse(response: response)
            {
                completion(.failure(responseError))
                return
            }

            guard let validData = data, error == nil else {
               print("API error: \(error!.localizedDescription)")
               completion(.failure(error!))
               return
            }

            let comments = try! JSONDecoder().decode([Comment].self, from:validData)
            DispatchQueue.main.async
            {
                completion(.success(comments))
            }
        }.resume()
    }
    
    func getUserPost(submitted: [String: Any], completion: @escaping (Result<[Jwt],Error>) ->())
    {
        guard let postUrl = URL(string: "\(baseURL)/user") else {fatalError()}
        
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
                completion(.failure(error!))
                return
            }
            print(data)
            
            do {
                let token = try! JSONDecoder().decode([Jwt].self, from:data)
                DispatchQueue.main.async
                {
                    completion(.success(token))
                }
            } catch {
                    print("JSONSerialization error:", error)
                }
        }
        task.resume()
    }
    
    func submitPost(submitted: [String: Any]){
        guard let postUrl = URL(string: "\(baseURL)/add_post_to_category") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        request.allHTTPHeaderFields!["Authorization"] = UserDefaults.standard.string(forKey: defaultsKeys.token)!
        
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
        request.allHTTPHeaderFields!["Authorization"] = UserDefaults.standard.string(forKey: defaultsKeys.token)!
        
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
        request.allHTTPHeaderFields!["Authorization"] = UserDefaults.standard.string(forKey: defaultsKeys.token)!
        
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
        request.allHTTPHeaderFields!["Authorization"] = UserDefaults.standard.string(forKey: defaultsKeys.token)!
        
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
    
    func submitContentReview(submitted: [String: Any])
    {
        guard let postUrl = URL(string: "\(baseURL)/content_review") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        request.allHTTPHeaderFields!["Authorization"] = UserDefaults.standard.string(forKey: defaultsKeys.token)!
        
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

    func createUser(submitted: [String: Any])
    {
        guard let postUrl = URL(string: "\(baseURL)/user") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        request.allHTTPHeaderFields!["Authorization"] = UserDefaults.standard.string(forKey: defaultsKeys.token)!
        
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
    
    func passwordReset(submitted: [String: Any])
    {
        guard let postUrl = URL(string: "\(baseURL)/password_reset") else {fatalError()}
        
        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        request.allHTTPHeaderFields!["Authorization"] = UserDefaults.standard.string(forKey: defaultsKeys.token)!
        
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
        request.allHTTPHeaderFields!["Authorization"] = UserDefaults.standard.string(forKey: defaultsKeys.token)!
        
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
    
    func blockUser(submitted: [String: Any])
    {
        guard let postUrl = URL(string: "\(baseURL)/block_user") else {fatalError()}

        var request = URLRequest(url: postUrl)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = Constants.DEFAULT_HTTP_HEADER_FIELDS
        request.allHTTPHeaderFields!["Authorization"] = UserDefaults.standard.string(forKey: defaultsKeys.token)!

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
    
    private func handleNetworkResponse(response: HTTPURLResponse) -> NetworkError? {
        switch response.statusCode {
        case 200...299: return (nil)
        case 300...399: return (NetworkError.redirectionError)
        case 400...499: return (NetworkError.clientError)
        case 500...599: return (NetworkError.serverError)
        case 600: return (NetworkError.invalidRequest)
        default: return (NetworkError.unknownError)
        }
    }

    public enum NetworkError: String, Error {
        case missingUrl = "URL is nil"
        case parametersNil = "Parameters were nil."
        case encodingFailed = "Parameter encoding failed."
        case redirectionError = "Redirection error"
        case clientError = "Client Error"
        case serverError = "Server Error"
        case invalidRequest = "Invalid Request"
        case unknownError = "Unknown Error"
        case dataError = "Error getting valid data."
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

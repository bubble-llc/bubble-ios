import Foundation

class API {
    func getPosts(completion: @escaping ([Post]) ->()){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {return}
        URLSession.shared.dataTask(with: url){ (data,_,_)in
            let posts = try! JSONDecoder().decode([Post].self, from:data!)
            DispatchQueue.main.async{
                completion(posts)
            }
            
            
        }
    .resume()
    }
}

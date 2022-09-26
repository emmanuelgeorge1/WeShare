//
//  RestViewModel.swift
//  WeShare
//
//  Created by Emmanuel George on 15/09/22.
//

import Foundation
class RestServices:NSObject{
    static let shared = RestServices()
    func fetchPosts(completion: @escaping (Result<[PostData],Error>) -> ()) {
        if let url = URL(string: "https://jsonplaceholder.typicode.com/posts") {
            URLSession.shared.dataTask(with: url) { data, response, err in
                if err == nil {
                    do {
                        let posts = try JSONDecoder().decode([PostData].self, from: data!)
                        DispatchQueue.main.async {
                            completion(.success(posts))
                        }
                    }
                    catch {
                        print("error fetching data from api")
                        completion(.failure(error))
                    }
                }
            }.resume()
        }
     
    }
    func deletePost(id: Int,completion: @escaping (Error?) -> ()){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(id)")
        else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        print(url)
        request.httpMethod = "DELETE"
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let err = error {
                    completion(err)
                    return
                }
                if let response = response as? HTTPURLResponse, response.statusCode != 200{
                    let errorString = String(data: data ?? Data(),encoding: .utf8) ?? ""
                    completion(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey:errorString]) )
                    return
                }
                completion(nil)
            }
        }.resume()
    }
    func createPost(title: String, body: String,completion: @escaping (Error?) -> ()){
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts")
        else {
            print("Error: cannot create URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        print("post title in service: \(title)")
        print("post body in service: \(body)")
        let newPostData = PostData(userId: 1, id: 101, title: title, body: body)
        do{
            let jsonData = try JSONEncoder().encode(newPostData)
            request.httpBody = jsonData
        }catch{
            print("Error on encoding\(error)")
        }
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                if let err = error {
                    completion(err)
                    return
                }
                if let response = response as? HTTPURLResponse, response.statusCode != 201{
                    let errorString = String(data: data ?? Data(),encoding: .utf8) ?? ""
                    completion(NSError(domain: "", code: response.statusCode, userInfo: [NSLocalizedDescriptionKey:errorString]) )
                    return
                }
                completion(nil)
            }
        }.resume()
    }
    func fetchComments(userId: Int,completion: @escaping (Result<[PostComment],Error>) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(userId)/comments")else{return}
        URLSession.shared.dataTask(with: url) { data, response, err in
            if err == nil {
                do {
                    let comment = try JSONDecoder().decode([PostComment].self, from: data!)
                    DispatchQueue.main.async {
                        completion(.success(comment))
                    }
                }
                catch {
                    print("error fetching data from api")
                    completion(.failure(error))
                }
            }
        }.resume()
    }
}

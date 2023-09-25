//
//  Networkmanager.swift
//  Miniapp_UIKit
//
//  Created by Valentin Taradaj on 2023. 08. 21..
//

import Foundation

protocol NetworkManagerProtocol{
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void)
    func getPosts(complition: @escaping (Result<[Post], Error>) -> Void)
}

class NetworkManager: NetworkManagerProtocol{
    static let shared = NetworkManager()
    
    private let baseURL = "https://jsonplaceholder.typicode.com"
    private let session = URLSession.shared
    
    private init() {}
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let url = URL(string: "\(baseURL)/users")!
        
        session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let users = try decoder.decode([User].self, from: data!)
                completion(.success(users))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
    func getPosts(complition: @escaping (Result<[Post], Error>) -> Void){
        let url = URL(string: "\(baseURL)/posts")!
        
        session.dataTask(with: url) { data, response, error in
            if let error = error{
                complition(.failure(error))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let posts = try decoder.decode([Post].self, from: data!)
                complition(.success(posts))
            } catch {
                complition(.failure(error))
            }
        }.resume()
    }
}

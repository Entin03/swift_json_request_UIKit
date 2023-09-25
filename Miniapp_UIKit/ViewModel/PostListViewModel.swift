//
//  PostListViewModel.swift
//  Miniapp_UIKit
//
//  Created by Valentin Taradaj on 2023. 08. 21..
//

import Foundation

class PostListViewModel {
    let user: User
    var posts: [Post] = []
    
    private var networkManager: NetworkManagerProtocol
    
    init(user: User, networkManager: NetworkManagerProtocol) {
        self.user = user
        self.networkManager = networkManager
    }

    func fetchPosts(completion: @escaping () -> Void) {
        networkManager.getPosts{ result in
            switch result {
            case .success(let posts):
                DispatchQueue.main.async {
                self.posts = posts.filter { $0.userId == self.user.id }
                completion()
            }
            case .failure(let error):
                print("Error fetching users: \(error)")
            }
        }
    }
}

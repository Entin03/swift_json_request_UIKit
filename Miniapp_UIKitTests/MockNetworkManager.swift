//
//  MockNetworkManager.swift
//  Miniapp_UIKitTests
//
//  Created by Valentin Taradaj on 2023. 09. 21..
//

class MockNetworkManager: NetworkManagerProtocol {
    
    func getUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        let mockUsers = [User(id: 1, name: "User1", username: "UserName1", email: "u1@a.com"),
                         User(id: 2, name: "User2", username: "UserName2", email: "u2@a.com")]
//        completion(.success(mockUsers))
    }
    
    func getPosts(complition: @escaping (Result<[Post], Error>) -> Void) {
        let mockPosts = [Post(userId: 1, id: 1, title: "Post1", body: "el gato"),
                        Post(userId: 2, id: 2, title: "Post2", body: "not el gato")]
    }
}

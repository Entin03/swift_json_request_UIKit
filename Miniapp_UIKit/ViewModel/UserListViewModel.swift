//
//  UserListViewModel.swift
//  Miniapp_UIKit
//
//  Created by Valentin Taradaj on 2023. 08. 21..
//

import Foundation

class UserListViewModel {
    private var networkManager: NetworkManagerProtocol
    var users: [User] = []
    
    init(networkManager: NetworkManagerProtocol) {
            self.networkManager = networkManager
    }

    func fetchUsers(completion: @escaping () -> Void) {
        networkManager.getUsers { result in
            switch result {
            case .success(let users):
                self.users = users
                completion()
            case .failure(let error):
                print("Error fetching users: \(error)")
            }
        }
    }
}


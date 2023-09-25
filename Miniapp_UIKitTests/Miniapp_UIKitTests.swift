//
//  Miniapp_UIKitTests.swift
//  Miniapp_UIKitTests
//
//  Created by Valentin Taradaj on 2023. 09. 21..
//

import XCTest
@testable import Miniapp_UIKit

final class Miniapp_UIKitTests: XCTestCase {
    
    func testFetchUsers() {
        let mockNetworkManager = MockNetworkManager()
        let viewModel = UserListViewModel(networkManager: mockNetworkManager)
        
        viewModel.fetchUsers {
            XCTAssertEqual(viewModel.users.count, 2)
        }
    }
    
    func testFetchPosts() {
        let mockNetwoekManager = MockNetworkManager()
        let user = User(id: 1, name: "User1", username: "UserName1", email: "u1@a.com")
        let viewModel = PostListViewModel(user: user, networkManager: mockNetwoekManager)
        
        viewModel.fetchPosts {
            XCTAssertEqual(viewModel.posts.count, 2)
        }
    }
}

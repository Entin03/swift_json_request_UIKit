//
//  Post.swift
//  Miniapp_UIKit
//
//  Created by Valentin Taradaj on 2023. 08. 21..
//

import Foundation

struct Post: Decodable{
    let userId: Int
    let id: Int
    let title: String
    let body: String
}

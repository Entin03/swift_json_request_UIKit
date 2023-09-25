//
//  PostDetailViewController.swift
//  Miniapp_UIKit
//
//  Created by Valentin Taradaj on 2023. 08. 23..
//

import UIKit

class PostDetailViewController: UIViewController {
    let post: Post

    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        PostDetailView.setupUI(for: view, post: post)
    }

    
}

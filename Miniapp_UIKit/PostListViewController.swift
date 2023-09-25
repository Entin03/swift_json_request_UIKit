//
//  PostListViewController.swift
//  Miniapp_UIKit
//
//  Created by Valentin Taradaj on 2023. 08. 21..
//

import UIKit

class PostListViewController: UITableViewController{
    let user : User
    private let postviewModel: PostListViewModel
    
    init (user: User, networkManager: NetworkManagerProtocol) {
        self.user = user
        self.postviewModel = PostListViewModel(user: user, networkManager: networkManager)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.backgroundColor = UIColor(rgb: 0xA1CCD1)
        
        title = "\(user.name)'s post"
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "postcell")
        
        postviewModel.fetchPosts {
            self.tableView.reloadData()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postviewModel.posts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "postcell", for: indexPath)
        let post = postviewModel.posts[indexPath.row]
        cell.textLabel?.text = post.title
        
        cell.textLabel?.textColor = UIColor(rgb: 0x27374D)
        cell.accessoryType = .disclosureIndicator
        cell.backgroundColor = UIColor(rgb: 0x61677A).withAlphaComponent(0.2)
        
        let cornerRadius: CGFloat = 30
            if indexPath.row == 0 {
                // Első cella: bal felső és jobb felső sarkok lekerekítése
                cell.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
            } else if indexPath.row == postviewModel.posts.count - 1 {
                // Utolsó cella: bal alsó és jobb alsó sarkok lekerekítése
                cell.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
            } else {
                // Köztes cellák: ne legyenek lekerekített sarkok
                cell.layer.maskedCorners = []
            }
        cell.layer.cornerRadius = cornerRadius
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = postviewModel.posts[indexPath.row]
        let postDetailViewController = PostDetailViewController(post: post)
        navigationController?.pushViewController(postDetailViewController, animated: true)
    }
    
}

//
//  PostDetailView.swift
//  Miniapp_UIKit
//
//  Created by Valentin Taradaj on 2023. 08. 23..
//

import UIKit

class PostDetailView{
    static func setupUI(for view: UIView, post: Post) {
        view.backgroundColor = .white
        
        let titleLabel = UILabel()
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.textColor = UIColor(rgb: 0x27374D)
        titleLabel.text = post.title
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let bodyLabel = UILabel()
        bodyLabel.font = UIFont.systemFont(ofSize: 18)
        bodyLabel.textColor = UIColor(rgb: 0x526D82)
        bodyLabel.text = post.body
        bodyLabel.numberOfLines = 0  // Allow multiline
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        
        let stackView = UIStackView(arrangedSubviews: [titleLabel, bodyLabel])
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        scrollView.addSubview(stackView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            stackView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 40),
            stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20),
            stackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, constant: -40)
        ])
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [
            UIColor(rgb: 0xA1CCD1).withAlphaComponent(0.55).cgColor,
            UIColor(rgb: 0xE9B384).withAlphaComponent(0.55).cgColor
        ]
        gradientLayer.frame = view.bounds
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

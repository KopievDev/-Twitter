//
//  MainTabController.swift
//  Twitter
//
//  Created by Ivan Kopiev on 29.06.2021.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: - Properties
    let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "new_twitt"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .white
        button.backgroundColor = .blue
        button.layer.cornerRadius = 28
        return button
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
        configureUI()
    }
    
    // MARK: - Helpers
    func configureUI() {
        view.addSubview(actionButton)
        actionButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor,
                            paddingBottom: 64, paddingRight: 16, width: 56, height: 56)
        
    }
    
    func configureViewControllers() {
        
        let feed = FeedController()
        let navFeed = templateNavigationController(withImageName: "house", rootViewController: feed)
        
        let explore = ExploreController()
        let navExplore = templateNavigationController(withImageName: "magnifyingglass", rootViewController: explore)
            
        let notifications = NotificationsController()
        let navNotifi = templateNavigationController(withImageName: "heart", rootViewController: notifications)

        let conversations = ConversationsController()
        let navConversations = templateNavigationController(withImageName: "envelope", rootViewController: conversations)

        viewControllers = [navFeed, navExplore, navNotifi, navConversations]
        
    }
    
    func templateNavigationController(withImageName name: String, rootViewController: UIViewController) -> UINavigationController {
        let nav = UINavigationController(rootViewController: rootViewController)
        nav.tabBarItem.image = UIImage(systemName: name)
        nav.navigationBar.barTintColor = .white
        return nav
    }
}

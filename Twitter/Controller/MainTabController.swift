//
//  MainTabController.swift
//  Twitter
//
//  Created by Ivan Kopiev on 29.06.2021.
//

import UIKit

class MainTabController: UITabBarController {

    // MARK: - Properties
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewControllers()
    }
    
    // MARK: - Helpers
    
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

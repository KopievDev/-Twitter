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
        feed.tabBarItem.image = UIImage(systemName: "house")
        
        let explore = ExploreController()
        explore.tabBarItem.image = UIImage(systemName: "magnifyingglass")

        let notifications = NotificationsController()
        notifications.tabBarItem.image = UIImage(systemName: "heart")

        let conversations = ConversationsController()
        conversations.tabBarItem.image = UIImage(systemName: "envelope")
        
        viewControllers = [feed, explore,notifications, conversations]
        
    }
}

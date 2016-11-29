//
//  CustomTabBarController.swift
//  facebookFeed
//
//  Created by Tihomir Videnov on 11/27/16.
//  Copyright © 2016 Tihomir Videnov. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let feedController = FeedController(collectionViewLayout: UICollectionViewFlowLayout())
        let navigationController = UINavigationController(rootViewController: feedController)
        navigationController.title = "News Feed"
        navigationController.tabBarItem.image = #imageLiteral(resourceName: "news_feed_icon")
        
        let friendRequestsController = FriendRequestsController()
        let secondNavigationController = UINavigationController(rootViewController: friendRequestsController)
        secondNavigationController.title = "Requests"
        secondNavigationController.tabBarItem.image = #imageLiteral(resourceName: "requests_icon")
        
        let messengerVC = UIViewController()
        messengerVC.navigationItem.title = "Messenger"
        let messangerNavigationController = UINavigationController(rootViewController: messengerVC)
        messangerNavigationController.title = "Messenger"
        messangerNavigationController.tabBarItem.image = #imageLiteral(resourceName: "messenger_icon")
        
        let notifVC = UIViewController()
        notifVC.navigationItem.title = "Notifications"
        let notificationsNavigationController = UINavigationController(rootViewController: notifVC)
        notificationsNavigationController.title = "Notifications"
        notificationsNavigationController.tabBarItem.image = #imageLiteral(resourceName: "globe_icon")
        
        let moreNavController = UIViewController()
        moreNavController.navigationItem.title = "More"
        let moreNavigationController = UINavigationController(rootViewController: moreNavController)
        moreNavigationController.title = "More"
        moreNavigationController.tabBarItem.image = #imageLiteral(resourceName: "more_icon")
        
        viewControllers = [navigationController, secondNavigationController, messangerNavigationController, notificationsNavigationController, moreNavigationController]
        
        
        tabBar.isTranslucent = false
        
        let topBorder = CALayer()
        topBorder.frame = CGRect(x: 0, y: 0, width: 1000, height: 0.5)
        topBorder.backgroundColor = UIColor.rgb(red: 229, green: 231, blue: 235).cgColor
        
        tabBar.layer.addSublayer(topBorder)
        tabBar.clipsToBounds = true
    }
     
}

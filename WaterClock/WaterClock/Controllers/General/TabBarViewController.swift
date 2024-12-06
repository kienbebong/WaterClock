//
//  TabBarViewController.swift
//  WaterClock
//
//  Created by Dinh Chi Kien on 28/10/24.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let vc1 = UINavigationController(rootViewController: NewsViewController())
        let vc2 = UINavigationController(rootViewController: TransactionViewController())
        let vc3 = UINavigationController(rootViewController: HomeViewController())
        let vc4 = UINavigationController(rootViewController: LookUpViewController())
        let vc5 = UINavigationController(rootViewController: NotificationViewController())
    
        vc1.tabBarItem.image = UIImage(systemName: "newspaper.fill")
        vc2.tabBarItem.image = UIImage(systemName: "bitcoinsign.circle.fill")
        vc3.tabBarItem.image = UIImage(systemName: "house.fill")
        vc4.tabBarItem.image = UIImage(systemName: "chart.bar.xaxis")
        vc5.tabBarItem.image = UIImage(systemName: "bell.circle.fill")

        tabBar.backgroundColor = .white
        
        setViewControllers([vc1, vc2, vc3, vc4, vc5], animated: true)
        
        vc1.title = NSLocalizedString("NEWS", comment: "News section title")
        vc2.title = NSLocalizedString("TRANSACTIONS", comment: "Transactions section title")
        vc3.title = NSLocalizedString("VTB", comment: "VTB section title")
        vc4.title = NSLocalizedString("LOOKUP", comment: "Lookup section title")
        vc5.title = NSLocalizedString("NOTIFICATIONS", comment: "Notifications section title")



        self.selectedIndex = 2

    }
}

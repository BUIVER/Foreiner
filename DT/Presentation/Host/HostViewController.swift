//
//  HostViewController.swift
//  DT
//
//  Created by Ivan Ermak on 10/9/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit

class HostViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let profileOV = ProfileOverviewViewController()
        let profileNavigation = UINavigationController(rootViewController: profileOV)
        profileOV.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        let heroesOV = HeroesOverviewViewController()
        let heroesNavigation = UINavigationController(rootViewController: heroesOV)
        heroesOV.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        self.viewControllers = [profileNavigation, heroesNavigation]
        // Do any additional setup after loading the view.
    }
}

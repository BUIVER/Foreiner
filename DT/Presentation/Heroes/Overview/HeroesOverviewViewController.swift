//
//  HeroesOverviewViewController.swift
//  DT
//
//  Created by Ivan Ermak on 10/9/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit

class HeroesOverviewViewController: UIViewController {

    let heroesSearchVC = HeroesSearchViewController()
    let overviewVM = HeroesOverviewViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        heroesSearchVC.delegate = self
        setupController()
        
        // Do any additional setup after loading the view.
        
    }
    func setupController() {
        let searchController = overviewVM.initiateSearchController(heroesSearchVC)
        navigationItem.title = "Heroes"
        navigationItem.searchController = searchController
    }
}

extension HeroesOverviewViewController: HeroesTransitionDelegate {
    func performTransition(hero: Hero) {
        let profileVC = HeroesResultViewController()
        profileVC.hero = hero
        show(profileVC, sender: nil)
    }
}

protocol HeroesTransitionDelegate {
    func performTransition(hero: Hero)
}

//
//  ViewController.swift
//  DT
//
//  Created by Ivan Ermak on 9/25/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit
import Nuke

class ProfileOverviewViewController: UIViewController {

    let searchResultsVC = SearchViewController()
    let overviewVM = ProfileOverviewViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        searchResultsVC.delegate = self
        setupController()
        
        // Do any additional setup after loading the view.
        
    }
    func setupController() {
        let searchController = overviewVM.initiateSearchController(searchResultsVC)
        navigationItem.title = "Search"
        navigationItem.searchController = searchController
    }
}

extension ProfileOverviewViewController: ProfileTransitionDelegate {
    func performTransition(for accountId: Int) {
        overviewVM.setDefaultUser(accountId)
        let profileVC = ProfileViewController(accountIdentifier: accountId)
        show(profileVC, sender: nil)
    }
}

protocol ProfileTransitionDelegate {
    func performTransition(for accountId: Int)
}

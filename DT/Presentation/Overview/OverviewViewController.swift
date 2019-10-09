//
//  ViewController.swift
//  DT
//
//  Created by Ivan Ermak on 9/25/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit
import Nuke

class OverviewViewController: UIViewController {

    let searchResultsVC = SearchResultsViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        searchResultsVC.delegate = self
        setupController()
        
        // Do any additional setup after loading the view.
        
    }
    func setupController() {
        let searchController: UISearchController = {
            let searchController = UISearchController(searchResultsController: searchResultsVC)
            searchController.searchResultsUpdater = searchResultsVC as UISearchResultsUpdating
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Input user name"
            searchController.searchBar.delegate = searchResultsVC
            return searchController
        }()
        navigationItem.searchController = searchController
    }
}

extension OverviewViewController: TransitionDelegate {
    func performTransition(for accountId: Int) {
        let profileVC = ProfileViewController(accountIdentifier: accountId)
        show(profileVC, sender: nil)
    }
}

protocol TransitionDelegate {
    func performTransition(for accountId: Int)
}

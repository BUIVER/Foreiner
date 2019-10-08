//
//  ViewController.swift
//  DT
//
//  Created by Ivan Ermak on 9/25/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit
import Nuke

class SearchViewController: UIViewController {
    
    let searchController: UISearchController = {
        let searchResultsVC = SearchResultsViewController()
        let searchController = UISearchController(searchResultsController: searchResultsVC)
        searchController.searchResultsUpdater = searchResultsVC as UISearchResultsUpdating
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Input user name"
        searchController.searchBar.delegate = searchResultsVC
        return searchController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupController()
        
        // Do any additional setup after loading the view.
        
    }
    func setupController() {
        navigationItem.searchController = searchController
//        definesPresentationContext = true
    }
}

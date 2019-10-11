//
//  OverviewViewModel.swift
//  DT
//
//  Created by Ivan Ermak on 10/9/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation
import UIKit

class ProfileOverviewViewModel {
    func setDefaultUser(_ accountId: Int) {
        UserDefaults.standard.set(accountId, forKey: "defaultUser")
    }
    
    func initiateSearchController(_ vc: SearchViewController) -> UISearchController {
        let searchController: UISearchController = {
            let searchController = UISearchController(searchResultsController: vc)
            searchController.searchResultsUpdater = vc as UISearchResultsUpdating
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.placeholder = "Input user name"
            searchController.searchBar.delegate = vc
            return searchController
        }()
        return searchController
    }
}

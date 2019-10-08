//
//  SearchResultsViewController.swift
//  DT
//
//  Created by Ivan Ermak on 10/2/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit
import Nuke
import ReactiveSwift

class SearchResultsViewController: UIViewController {
    
    var searchResults: [User]?
    let searchVM = SearchViewModel()
    var table: UITableView!
    let lifetime = Lifetime.make().lifetime
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        // Do any additional setup after loading the view.
    }
    
}

//MARK: SearchController configuration

extension SearchResultsViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        searchVM.startSearch(searchController.searchBar.text ?? "", completion: { [weak self] _ in
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        })
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults = []
        table.reloadData()
    }
}
//MARK: UITABLEVIEW configuration
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchVM.rowsAmount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "searchCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchResultsTableCell else {
            return UITableViewCell()
        }
        searchVM.loadCell(for: indexPath)
        guard let item = searchVM.searchItem else {
            return UITableViewCell()
        }
        cell.loadCell(withData: item)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = searchResults?[indexPath.row] {
            let profileVC = ProfileViewController(accountIdentifier: data.accountId)
            UserDefaults.standard.set(data.accountId, forKey: "defaultUser")
            show(profileVC, sender: nil)
        }
    }
    func setupTable() {
        table = UITableView(frame: CGRect(x: 0, y: self.navigationController?.navigationBar.bounds.height ?? 0, width: self.view.bounds.width, height: self.view.bounds.height - (self.navigationController?.navigationBar.bounds.height ?? 0)))
        table.register(UINib(nibName: "SearchResultsTableCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
    }
}


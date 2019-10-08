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
    var filteredUsers = [User]()
    let searchVM = SearchViewModel()
    var network = OpenDotaService()
    let searchService = SearchService()
    var parser = DataParseService()
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
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        searchVM.startSearch(searchText)
        searchService.performSearch(searchText).debounce(3, on: QueueScheduler.main, discardWhenCompleted: true).startWithResult() { [weak self] data in
            guard let foundData = data.value else {return}
            self?.searchResults = self?.parser.parseSearchData(foundData)
            DispatchQueue.main.async {
                self?.table.reloadData()
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults = []
        table.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        if (searchResults?.count ?? 0 > 0) {
            filteredUsers = (searchResults?.filter({( user : User) -> Bool in
                return user.personaname.lowercased().contains(searchText.lowercased())
            }) ?? [])
            table.reloadData()
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let text = searchBar.text {
            searchService.performSearch(text).startWithResult() { [weak self] data in
                guard let foundData = data.value else {return}
                self?.searchResults = self?.parser.parseSearchData(foundData)
                DispatchQueue.main.async {
                    self?.table.reloadData()
                }
            }
        }
    }
}
//MARK: UITABLEVIEW configuration
extension SearchResultsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cellIdentifier = "searchCell"
            guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SearchResultsTableCell else {return UITableViewCell()}
            guard let user = searchResults?[indexPath.row] else {return UITableViewCell()}
            cell.accountIdLabel.text = String(user.accountId)
            Nuke.loadImage(with: user.avatarfull, into: cell.avatarImageView)
            cell.personaNameLabel.text = user.personaname
            cell.lastMatchTimeLabel.text = user.lastMatchTime ?? ""
            return cell
        } else {
            return UITableViewCell()
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        }
        return sectionName[section-1]
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let data = searchResults?[indexPath.row] {
            let profileVC = ProfileViewController(accountIdentifier: data.accountId)
            UserDefaults.standard.set(data.accountId, forKey: "defaultUser")
            show(profileVC, sender: nil)
            //self.navigationController?.pushViewController(profileVC, animated: true)
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


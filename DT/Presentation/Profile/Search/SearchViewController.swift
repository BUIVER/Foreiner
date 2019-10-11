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
import ReactiveCocoa
import Result

class SearchViewController: UIViewController {
    
    var searchResults: [User]?
    let searchVM = SearchViewModel()
    var table: UITableView!
    var delegate: ProfileTransitionDelegate!
    var (signal, observer) = Signal<String, NoError>.pipe()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        // Do any additional setup after loading the view.
    }
    
}

//MARK: SearchController configuration

extension SearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        searchController.searchBar.reactive.continuousTextValues.take(duringLifetimeOf: self).debounce(1.5, on: QueueScheduler.main).observe { [weak self] signal in
            self?.searchVM.startSearch(searchController.searchBar.text ?? "").start() { [weak self] _ in
                DispatchQueue.main.async {
                    self?.table.reloadData()
                }
            }
        }
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchResults = []
        table.reloadData()
    }
}
//MARK: UITABLEVIEW configuration
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
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
        self.delegate.performTransition(for: searchVM.accountForCell(at: indexPath))
    }
    func setupTable() {
        let barHeight = self.navigationController?.navigationBar.bounds.height ?? 0
        table = UITableView(frame: CGRect(x: 0, y: barHeight, width: self.view.bounds.width, height: self.view.bounds.height - barHeight))
        table.register(UINib(nibName: "SearchResultsTableCell", bundle: nil), forCellReuseIdentifier: "searchCell")
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
    }
}


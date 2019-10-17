//
//  HeroesOverviewViewController.swift
//  DT
//
//  Created by Ivan Ermak on 10/9/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit
import ReactiveSwift
import ReactiveCocoa
import CoreML

class HeroesSearchViewController: UIViewController {
    var heroesVM = HeroesSearchViewModel()
    var table: UITableView!
    var delegate: HeroesTransitionDelegate!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        self.view.backgroundColor = .white
        // Do any additional setup after loading the view.
    }
}
extension HeroesSearchViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        heroesVM.filterHeroes(searchController.searchBar.text ?? "")
        table.reloadData()
    }
}


extension HeroesSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return heroesVM.rowsAmount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "heroCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HeroesSearchTableCell else {
            return UITableViewCell()
        }
        heroesVM.loadCell(for: indexPath)
        guard let item = heroesVM.heroItem else {
            return UITableViewCell()
        }
        cell.loadCell(withData: item)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate.performTransition(hero: heroesVM.filteredHeroes[indexPath.row])
    }
    func setupTable() {
        let barHeight = self.navigationController?.navigationBar.bounds.height ?? 0
        table = UITableView(frame: CGRect(x: 0, y: barHeight, width: self.view.bounds.width, height: self.view.bounds.height - barHeight))
        table.register(UINib(nibName: "HeroesSearchTableCell", bundle: nil), forCellReuseIdentifier: "heroCell")
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
    }
}

//
//  HeroesOverviewViewController.swift
//  DT
//
//  Created by Ivan Ermak on 10/9/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit
import ReactiveSwift

class HeroesOverviewViewController: UIViewController {

    let heroesSearchVC = HeroesSearchViewController()
    let overviewVM = HeroesOverviewViewModel()
    var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        heroesSearchVC.delegate = self
        setupTable()
        self.overviewVM.getHeroesData().start() { [weak self] _ in
            DispatchQueue.main.async {
                self?.heroesSearchVC.heroesVM.heroes = self?.overviewVM.heroes ?? []
                self?.table.reloadData()
            }
        }
        setupController()
        
        // Do any additional setup after loading the view.
        
    }
    func setupController() {
        let searchController = overviewVM.initiateSearchController(heroesSearchVC)
        navigationItem.title = "Heroes"
        navigationItem.searchController = searchController
    }
    func setupTable() {
        let frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        table = UITableView(frame: frame)
        table.register(UINib(nibName: "HeroesSearchTableCell", bundle: nil), forCellReuseIdentifier: "heroCell")
        table.delegate = self
        table.dataSource = self
        self.view.addSubview(table)
    }
}

extension HeroesOverviewViewController: HeroesTransitionDelegate {
    func performTransition(hero: Hero) {
        let profileVC = HeroesResultViewController()
        profileVC.hero = hero
        show(profileVC, sender: nil)
    }
}
extension HeroesOverviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return overviewVM.heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "heroCell"
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? HeroesSearchTableCell else {
            return UITableViewCell()
        }
        overviewVM.loadCell(for: indexPath)
        guard let item = overviewVM.heroItem else {
            return UITableViewCell()
        }
        cell.loadCell(withData: item)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performTransition(hero: overviewVM.heroes[indexPath.row])
    }
    
}
protocol HeroesTransitionDelegate {
    func performTransition(hero: Hero)
}

//
//  HeroesOverviewViewModel.swift
//  DT
//
//  Created by Ivan Ermak on 10/9/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation
import UIKit
import ReactiveSwift

class HeroesOverviewViewModel {
    
    var heroItem: HeroesSearchItem?
    var heroes: [Hero] = []
    var heroesService = HeroesService()
    var parser = NetworkDataParseService()
    var dataBaseService = DataBaseService()
    var dataBaseParse = DataBaseParseService()
    func setDefaultUser(_ heroId: Int) {
        UserDefaults.standard.set(heroId, forKey: "defaultHero")
    }
    
    func initiateSearchController(_ vc: HeroesSearchViewController) -> UISearchController {
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
    func getHeroesData() -> SignalProducer<[Hero], Error> {
        let result = dataBaseService.performFetch()
        if (result.isContained) {
            return SignalProducer { [weak self] observer, _ in
                self?.heroes = self?.dataBaseParse.parseHeroData(result.data) ?? []
                self?.heroes.sort(by: { x, y -> Bool in
                    x.localizedName < y.localizedName
                })
                observer.sendCompleted()
            }
        } else {
            return SignalProducer { [weak self] (observer, lifetime) in
                self?.heroesService.getHeroesList().startWithResult() { responseData in
                    if let heroData = responseData.result.value {
                        self?.heroes = self?.parser.parseHeroData(heroData) ?? []
                        self?.heroes.forEach { hero in
                            let heroDB = Heroes(context: CoreDataManager.instance.managedObjectContext)
                            heroDB.roles = hero.roles
                            heroDB.attackType = hero.attackType
                            heroDB.attribute = hero.attribute
                            heroDB.name = hero.localizedName
                            heroDB.id = Int64(hero.id)
                            heroDB.systemName = hero.name
                        }
                        CoreDataManager.instance.saveContext()
                        observer.sendCompleted()
                        
                    }
                }
            }
        }
    }
    func loadCell(for indexPath: IndexPath) {
        let hero = heroes[indexPath.row]
        let name = hero.localizedName
        let attribute = hero.attribute
        heroItem = HeroesSearchItem(heroName: name, attribute: attribute)
    }
}

//
//  HeroesOverviewViewModel.swift
//  DT
//
//  Created by Ivan Ermak on 10/9/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation
import ReactiveSwift

class HeroesSearchViewModel {
    var heroes: [Hero] = []
    var filteredHeroes: [Hero] = []
    var heroItem: HeroesSearchItem?
    var profileViewItem: HeroesSearchItem?
    
    func rowsAmount() -> Int {
        return filteredHeroes.count
    }
    func loadCell(for indexPath: IndexPath) {
        let hero = filteredHeroes[indexPath.row]
        let name = hero.localizedName
        let attribute = hero.attribute
        heroItem = HeroesSearchItem(heroName: name, attribute: attribute)
    }
    func filterHeroes(_ searchText: String) {
        filteredHeroes = heroes.filter({
            $0.localizedName.lowercased().contains(searchText.lowercased())
        })
    }
}
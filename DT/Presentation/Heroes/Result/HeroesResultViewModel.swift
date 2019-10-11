//
//  HeroesResultViewModel.swift
//  DT
//
//  Created by Ivan Ermak on 10/10/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation
    
class HeroesResultViewModel {
    var hero: Hero!
    func fillHeroItem(for view: HeroView) {
        let item = fillItem()
        view.loadView(withData: item)
    }
    func fillItem() -> HeroesResultItem {
        var rolesString = ""
        hero.roles.forEach { role in
            rolesString.append("\(role), ")
        }
        rolesString.removeLast(2 )
        return HeroesResultItem(heroName: hero.localizedName, attribute: hero.attribute, roles: rolesString, attackType: hero.attackType)
    }
}

//
//  DataBaseParseService.swift
//  DT
//
//  Created by Ivan Ermak on 10/16/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation

class DataBaseParseService {
    func parseHeroData(_ data: [Heroes]) -> [Hero] {
        var heroes: [Hero] = []
        data.forEach { heroData in
            var roles = ""
            heroData.roles?.forEach({ role in
                roles.append("\(role), ")
            })
            roles.removeLast(2)
            let hero = Hero(id: Int(heroData.id), name: heroData.systemName ?? "", localizedName: heroData.name ?? "", attribute: heroData.attribute ?? "", attackType: heroData.attackType ?? "", roles: heroData.roles ?? [])
            heroes.append(hero)
        }
        return heroes
    }
}

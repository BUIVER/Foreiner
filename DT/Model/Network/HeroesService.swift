//
//  HeroesService.swift
//  DT
//
//  Created by Ivan Ermak on 10/9/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation
import ReactiveSwift

class HeroesService {
    static let shared = HeroesService()
    let apiLink = "https://api.opendota.com/api/heroes"
    let imageLink = URL(string: "https://backendlessappcontent.com/34097D04-0401-325A-FF3E-447E5C4A6D00/console/ifaliiytdlkwvxvkjktzihqbdtdrolxpzqca/files/view/images/")
    let openDotaService = OpenDotaService()
    func getHeroesList() -> SignalProducer<Data, Error> {
        SignalProducer { [weak self] (observer, lifetime) in
            guard let url = URL(string: self?.apiLink ?? "") else {
                return
            }
            self?.openDotaService.setRequest(url).take(during: lifetime).startWithResult() { result in
                if let data = result.value?.0 {
                    observer.send(value: data)
                } else if let error = result.error{
                    observer.send(error: error)
                }
            }
        }
    }
    func getHeroLogo(hero: String) -> URL? {
        let heroPath = hero.replacingOccurrences(of: " ", with: "_").replacingOccurrences(of: "'", with: "")
        guard let url = imageLink?.appendingPathComponent(heroPath + "_icon.png") else { return nil }
        return url
    }
    
}

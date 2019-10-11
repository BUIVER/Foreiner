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
    let link = "https://api.opendota.com/api/heroes"
    let openDotaService = OpenDotaService()
    func getHeroesList() -> SignalProducer<Data, Error> {
        SignalProducer { [weak self] (observer, lifetime) in
            guard let url = URL(string: self?.link ?? "") else {
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
    
}

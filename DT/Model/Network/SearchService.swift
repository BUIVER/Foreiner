//
//  SearchService.swift
//  DT
//
//  Created by Ivan Ermak on 10/7/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation
import Result
import ReactiveSwift

class SearchService {
    var openDotaService = OpenDotaService()
    let link = "https://api.opendota.com/api/search?q="
    func performSearch(_ searchedPlayer: String) -> SignalProducer<Data, Error> {
        SignalProducer { [weak self] (observer, lifetime) in
            let player = searchedPlayer.replacingOccurrences(of: " ", with: "%20")
            let urlString = (self?.link ?? "") + player
            guard let url = URL(string: urlString) else {
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

//
//  ProfileService.swift
//  DT
//
//  Created by Ivan Ermak on 10/7/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation
import Result
import ReactiveSwift

class ProfileService {
    let link = "https://api.opendota.com/api/players/"
    let openDotaService = OpenDotaService()
    func getProfile(_ accountId: Int) -> SignalProducer<Data, Error> {
        let producer: SignalProducer<Data, Error> = SignalProducer { [weak self] (observer, _) in
            let urlString = (self?.link ?? "") + String(accountId)
            guard let url = URL(string: urlString) else {
                return
            }
            self?.openDotaService.setRequest(url).startWithResult() { result in
                if let data = result.value?.0 {
                    observer.send(value: data)
                } else if let error = result.error {
                    observer.send(error: error)
                }
            }
        }
        return producer
    }
}

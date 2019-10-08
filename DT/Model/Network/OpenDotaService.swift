//
//  Network.swift
//  DT
//
//  Created by Ivan Ermak on 9/26/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation
import Nuke
import ReactiveSwift
import Result

class OpenDotaService {
    let session = URLSession.shared
   // let lifetime = Lifetime.make().lifetime
    func setRequest(_ url: URL) -> SignalProducer<(Data, URLResponse), Error> {
        let producer: SignalProducer<(Data, URLResponse), Error> = SignalProducer { [weak self] (observer, lifetime) in
            let request = URLRequest(url: url)
            let task = self?.session.dataTask(with: request, completionHandler: { data, response, error in
                if let error = error {
                    observer.send(error: error)
                }
                if let data = data, let response = response {
                    observer.send(value: (data, response))
                }
            })
            task?.resume()
        }
        return producer
        
    }
}

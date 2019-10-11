//
//  Network.swift
//  DT
//
//  Created by Ivan Ermak on 10/11/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation
import ReactiveSwift
class Network {
    let session = URLSession.shared
    let compositeDispose = CompositeDisposable()
    let link = "https://api.opendota.com/api/search?q="
    let linkTwo = "https://api.opendota.com/api/players/"
    func setRequest(_ url: URL) -> SignalProducer<(Data, URLResponse), Error> {
        let producer: SignalProducer<(Data, URLResponse), Error> = SignalProducer { [weak self] (observer, lifetime) in
            let request = URLRequest(url: url)
            let task = self?.session.reactive.data(with: request).startWithResult { result in
                if let error = result.error {
                    observer.send(error: error)
                }
                if let data = result.value {
                    observer.send(value: data)
                }
            }
            self?.compositeDispose.add(task)
        }
        return producer
        
    }
    func performSearch(_ searchedPlayer: String) -> SignalProducer<Data, Error> {
        SignalProducer { [weak self] (observer, lifetime) in
            let player = searchedPlayer.replacingOccurrences(of: " ", with: "%20")
            let urlString = (self?.link ?? "") + player
            guard let url = URL(string: urlString) else {
                return
            }
            self?.setRequest(url).startWithResult() { result in
                if let data = result.value?.0 {
                    observer.send(value: data)
                } else if let error = result.error{
                    observer.send(error: error)
                }
            }
        }
    }
    func getProfile(_ accountId: Int) -> SignalProducer<Data, Error> {
        let producer: SignalProducer<Data, Error> = SignalProducer { [weak self] (observer, _) in
            let urlString = (self?.linkTwo ?? "") + String(accountId)
            guard let url = URL(string: urlString) else {
                return
            }
            self?.compositeDispose.add(self?.setRequest(url).startWithResult() { result in
                if let data = result.value?.0 {
                    observer.send(value: data)
                } else if let error = result.error {
                    observer.send(error: error)
                }
            })
        }
        return producer
    }
}

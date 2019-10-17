//
//  SearchResultViewModel.swift
//  DT
//
//  Created by Ivan Ermak on 10/8/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class SearchViewModel {
    var searchResults: [User]?
    var filteredUsers = [User]()
    var network = OpenDotaService()
    let searchService = SearchService()
    var parser = NetworkDataParseService()
    var searchItem: SearchItem?
    
    func startSearch(_ text: String) -> SignalProducer<[User], NoError> {
        SignalProducer { [weak self] (observer, lifetime) in
            self?.searchService.performSearch(text).startWithResult() { [weak self] data in
                guard let foundData = data.value else {return}
                self?.searchResults = self?.parser.parseSearchData(foundData)
                observer.sendCompleted()
            }
        }
    }
    func filterContent(_ text: String) {
        if (searchResults?.count ?? 0 > 0) {
            filteredUsers = searchResults?.filter() {
                $0.personaname.lowercased().contains(text.lowercased())
            } ?? []
        }
    }
    func rowsAmount() -> Int {
        return searchResults?.count ?? 0
    }
    func accountForCell(at indexPath: IndexPath) -> Int {
        guard let accountId = searchResults?[indexPath.row].accountId else {
            return 0
        }
        return accountId
    }
    
    func loadCell(for indexPath: IndexPath) {
        let user = searchResults?[indexPath.row]
        guard let url = user?.avatarfull else {
            return
        }
        guard let accountId = user?.accountId else {
            return
        }
        guard let personName = user?.personaname else {
            return
        }
        let date = user?.lastMatchTime ?? ""
        let accountIdText = String(accountId)
        searchItem = SearchItem(accountId: accountIdText, personName: personName, imageURL: url, date: date)
    }
}

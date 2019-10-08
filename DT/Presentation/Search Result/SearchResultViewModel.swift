//
//  SearchResultViewModel.swift
//  DT
//
//  Created by Ivan Ermak on 10/8/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation
import ReactiveSwift

class SearchViewModel {
    var searchResults: [User]?
    var filteredUsers = [User]()
    var network = OpenDotaService()
    let searchService = SearchService()
    var parser = DataParseService()
    var searchItem: SearchResultsItem?
    
    func startSearch(_ text: String, completion: @escaping ([User]) -> Void) {
        searchService.performSearch(text).debounce(3, on: QueueScheduler.main, discardWhenCompleted: true).startWithResult() { [weak self] data in
            guard let foundData = data.value else {return}
            self?.searchResults = self?.parser.parseSearchData(foundData)
            completion(self?.searchResults ?? [])
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
        searchItem = SearchResultsItem(accountId: accountIdText, personName: personName, imageURL: url, date: date)
    }
}

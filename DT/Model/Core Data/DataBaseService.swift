//
//  Data Base Service.swift
//  DT
//
//  Created by Ivan Ermak on 10/16/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation

class DataBaseService {
    func performFetch() -> (data: [Heroes], isContained: Bool) {
        do {
            let heroesData = try CoreDataManager.instance.managedObjectContext.fetch(CoreDataManager.instance.fetchRequest)
            return (heroesData, heroesData.count > 0)
        } catch {
            print(error.localizedDescription)
        }
        return ([], false)
        
    }
}

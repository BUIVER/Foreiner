//
//  OverviewViewModel.swift
//  DT
//
//  Created by Ivan Ermak on 10/9/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation

class OverviewViewModel {
    func setDefaultUser(_ accountId: Int) {
        UserDefaults.standard.set(accountId, forKey: "defaultUser")
    }
}

//
//  ProfileVIewModel.swift
//  DT
//
//  Created by Ivan Ermak on 10/7/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation
import ReactiveSwift
import Result

class ProfileViewModel {
    var profileService = ProfileService()
    var parser = NetworkDataParseService()
    var player: Player?
    var profileViewItem: ProfileViewItem?
    func getProfileData(_ accountId: Int, completion: @escaping () -> Void) {
        profileService.getProfile(accountId).startWithResult() { responseData in
            if let playerData = responseData.result.value {
                let ii = self.parser.parsePlayerData(playerData)
                self.player = ii
                self.fillProfileItem()
                completion()
            }
        }
    }
    func fillProfileItem() {
        guard let url = player?.avatarLink else {
            return
        }
        guard let accountText = player?.accountId else {
            return
        }
        guard let usernameText = player?.personaname else {
            return
        }
        profileViewItem = ProfileViewItem(imageURL: url, accountId: String(accountText), username: usernameText)
    }
}

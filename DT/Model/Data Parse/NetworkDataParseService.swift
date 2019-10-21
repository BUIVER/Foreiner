//
//  DataParsing.swift
//  DT
//
//  Created by Ivan Ermak on 9/27/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import Foundation

class NetworkDataParseService {
    func parseSearchData(_ jsonData: Data) -> [User] {
        var parsedData: [User] = []
        do {
            guard let data = try JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [JSON] else {
                return parsedData
            }
            if data.count > 0 {
                for index in 0..<data.count {
                    let playerData = data[index]
                    guard let similarity = playerData["similarity"] as? Double else {continue}
                    guard let personaName = playerData["personaname"] as? String else {continue}
                    guard let accountId = playerData["account_id"] as? Int else {continue}
                    guard let avatarLinkString = playerData["avatarfull"] as? String else {continue}
                    guard let avatarLink = URL(string: avatarLinkString) else {continue}
                    var lastMatchTime = playerData["last_match_time"] as? String
                    if lastMatchTime != nil {
                        lastMatchTime?.removeLast(14)
                    }
                    let user = User(similarity: similarity, personaname: personaName, accountId: accountId, avatarfull: avatarLink, lastMatchTime: lastMatchTime)
                    parsedData.append(user)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return parsedData
    }
    func parsePlayerData(_ data: Data) -> Player {
        var jsonData: JSON?
        do {
            jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? JSON
        } catch {
            print(error.localizedDescription)
        }
        guard let profileData = jsonData?["profile"] as? JSON else {fatalError()}
        guard let accountId = profileData["account_id"] as? Int else {fatalError()}
        guard let avatarLinkString = profileData["avatarfull"] as? String else { fatalError() }
        guard let avatarLink = URL(string: avatarLinkString) else { fatalError() }
        let name = profileData["name"] as? String ?? ""
        guard let personaName = profileData["personaname"] as? String else {fatalError()}
        guard let profileLinkString = profileData["profileurl"] as? String else { fatalError() }
        guard let profileUrl = URL(string: profileLinkString) else {fatalError()}
        guard let steamId = profileData["steamid"] as? String else {fatalError()}
        let soloRank = jsonData?["solo_competitive_rank"] as? String ?? ""
        let rankTier = jsonData?["rank_tier"] as? Int ?? 0
        
        let player = Player(rankTier: rankTier, accountId: accountId, avatarLink: avatarLink, personaname: personaName, name: name, steamId: steamId, profileUrl: profileUrl, soloCompetitiveRank: soloRank)
        return player
    }
    func parseHeroData(_ data: Data) -> [Hero] {
        var parsedData: [Hero] = []
        do {
            guard let jsonData = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [JSON] else {
                return parsedData
            }
            if jsonData.count > 0 {
                for index in 0..<jsonData.count {
                    let heroData = jsonData[index]
                    guard let id = heroData["id"] as? Int else {
                        continue
                    }
                    guard let name = heroData["name"] as? String else {
                        continue
                    }
                    guard let localizedName = heroData["localized_name"] as? String else {
                        continue
                    }
                    guard let attribute = heroData["primary_attr"] as? String else {
                        continue
                    }
                    guard let attackType = heroData["attack_type"] as? String else {
                        continue
                    }
                    guard let roles = heroData["roles"] as? [String] else {
                        continue
                    }
                    let hero = Hero(id: id, name: name, localizedName: localizedName, attribute: attribute, attackType: attackType, roles: roles)
                    parsedData.append(hero)
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        return parsedData
    }
}

//
//  HeroesSearchTableCell.swift
//  DT
//
//  Created by Ivan Ermak on 10/10/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit
import Nuke
class HeroesSearchTableCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var attributeLabel: UILabel!
    @IBOutlet private weak var heroLogo: UIImageView!
    
    override func prepareForReuse() {
        self.nameLabel.text = ""
        self.attributeLabel.text = ""
    }
    func loadCell(withData data: HeroesSearchItem) {
        self.nameLabel.text = data.heroName
        self.attributeLabel.text = data.attribute
        self.attributeLabel.textColor = UIColor(named: data.attribute)
        
        guard let url = HeroesService.shared.getHeroLogo(hero: data.heroName) else {
            return
        }
        loadImage(with: url, into: heroLogo)
    }
}

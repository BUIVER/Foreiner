//
//  HeroesSearchTableCell.swift
//  DT
//
//  Created by Ivan Ermak on 10/10/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit

class HeroesSearchTableCell: UITableViewCell {
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var attributeLabel: UILabel!
    
    func loadCell(withData data: HeroesSearchItem) {
        self.nameLabel.text = data.heroName
        self.attributeLabel.text = data.attribute
        self.attributeLabel.textColor = UIColor(named: data.attribute)
    }
}

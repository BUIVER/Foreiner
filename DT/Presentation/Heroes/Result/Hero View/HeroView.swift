//
//  HeroView.swift
//  DT
//
//  Created by Ivan Ermak on 10/10/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit
import Nuke

class HeroView: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var attributeLabel: UILabel!
    @IBOutlet private weak var attackTypeLabel: UILabel!
    @IBOutlet private weak var rolesLabel: UILabel!
    @IBOutlet private weak var heroLogoView: UIImageView!
    override func awakeFromNib() {
    }
    func loadView(withData data: HeroesResultItem) {
        self.nameLabel.text = data.heroName
        self.attributeLabel.text = data.attribute
        self.attributeLabel.textColor = UIColor(named: data.attribute)
        self.attackTypeLabel.text = data.attackType
        self.rolesLabel.text = data.roles
        loadImage(with: HeroesService.shared.getHeroLogo(hero: data.heroName)!, into: self.heroLogoView)
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        loadFromNib()
    }
    private func loadFromNib() {
        Bundle.main.loadNibNamed("HeroView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}

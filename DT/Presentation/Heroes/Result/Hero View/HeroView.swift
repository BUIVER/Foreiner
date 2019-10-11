//
//  HeroView.swift
//  DT
//
//  Created by Ivan Ermak on 10/10/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit

class HeroView: UIView {
    @IBOutlet private weak var contentView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var attributeLabel: UILabel!
    @IBOutlet weak var attackTypeLabel: UILabel!
    @IBOutlet weak var rolesLabel: UILabel!
    override func awakeFromNib() {
    }
    func loadView(withData data: HeroesResultItem) {
        self.nameLabel.text = data.heroName
        self.attributeLabel.text = data.attribute
        self.attributeLabel.textColor = UIColor(named: data.attribute)
        self.attackTypeLabel.text = data.attackType
        self.rolesLabel.text = data.roles
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

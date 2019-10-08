//
//  UIProfileView.swift
//  DT
//
//  Created by Ivan Ermak on 9/27/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit

class UIProfileView: UIView {
    @IBOutlet var contentView: UIView!
    @IBOutlet var profileImage: UIImageView!
    @IBOutlet var personName: UILabel!
    @IBOutlet var accountId: UILabel!
    override func awakeFromNib() {
        contentView.backgroundColor = .white
        profileImage.layer.cornerRadius = profileImage.bounds.width / 2
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
        Bundle.main.loadNibNamed("UIProfileView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

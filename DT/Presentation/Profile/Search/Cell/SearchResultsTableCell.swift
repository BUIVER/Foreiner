//
//  SearchResultsTableViewCell.swift
//  DT
//
//  Created by Ivan Ermak on 10/1/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit
import Nuke

class SearchResultsTableCell: UITableViewCell {
    @IBOutlet private weak var avatarImageView: UIImageView!
    @IBOutlet private weak var personaNameLabel: UILabel!
    @IBOutlet private weak var accountIdLabel: UILabel!
    @IBOutlet private weak var lastMatchTimeLabel: UILabel!
    
    func loadCell(withData data: SearchItem) {
        self.accountIdLabel.text = data.accountId
        Nuke.loadImage(with: data.imageURL, into: self.avatarImageView)
        self.personaNameLabel.text = data.personName
        self.lastMatchTimeLabel.text = data.date 
    }
}

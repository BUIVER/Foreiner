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
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var personaNameLabel: UILabel!
    @IBOutlet weak var accountIdLabel: UILabel!
    @IBOutlet weak var lastMatchTimeLabel: UILabel!
    
    func loadCell(withData data: SearchItem) {
        self.accountIdLabel.text = data.accountId
        Nuke.loadImage(with: data.imageURL, into: self.avatarImageView)
        self.personaNameLabel.text = data.personName
        self.lastMatchTimeLabel.text = data.date 
    }
}

//
//  ProfileViewController.swift
//  DT
//
//  Created by Ivan Ermak on 9/25/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit
import Nuke

class ProfileViewController: UIViewController {
    var player: Player!
    var accountId: Int
    let profileVM = ProfileViewModel()
    init(accountIdentifier: Int) {
        accountId = accountIdentifier
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        accountId = 0
        super.init(coder: coder)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .lightGray
        let profileView = UIProfileView(frame: CGRect(x: 0, y: 85, width: self.view.bounds.width, height: 200))
        self.profileVM.getProfileData(accountId, completion: {
            DispatchQueue.main.async {
            self.loadProfile(profileView)
            }
        })
        self.view.addSubview(profileView)
    }
    func loadProfile(_ profileView: UIProfileView) {
        if let item = profileVM.profileViewItem {
            profileView.accountId.text = item.accountId
            Nuke.loadImage(with: item.imageURL, into: profileView.profileImage)
            profileView.personName.text = item.username
        }
    }
        
}

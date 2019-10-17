//
//  HeroesResultViewController.swift
//  DT
//
//  Created by Ivan Ermak on 10/10/19.
//  Copyright © 2019 Ivan Ermak. All rights reserved.
//

import UIKit

class HeroesResultViewController: UIViewController {
    
    var hero: Hero?
    let heroesResultVM = HeroesResultViewModel()
    var heroLogo: UIImage?
    override func viewDidLoad() {
        super.viewDidLoad()
        heroesResultVM.hero = hero
        self.view.backgroundColor = .lightGray
        let heroView = HeroView(frame: CGRect(x: 0, y: 85, width: self.view.bounds.width, height: 200))
        self.heroesResultVM.fillHeroItem(for: heroView)
        self.view.addSubview(heroView)
    }
}


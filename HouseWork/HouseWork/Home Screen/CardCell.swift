//
//  CardCell.swift
//  HouseWork
//
//  Created by Sean Lohman on 2/1/19.
//  Copyright © 2019 Sean Lohman. All rights reserved.
//

import UIKit

class CardCell: UICollectionViewCell {
    
    @IBOutlet weak var CardViewLabel: UILabel!
    
        func configure() {
            self.layer.cornerRadius = 25.0
            self.layer.borderWidth = 1.0
            self.layer.borderColor = UIColor.clear.cgColor
            self.backgroundColor = UIColor.white
            self.layer.masksToBounds = true
            
//            self.layer.shadowColor = UIColor.lightGray.cgColor
//            self.layer.shadowOffset = CGSize.zero
//            self.layer.shadowRadius = 2.0
//            self.layer.shadowOpacity = 1.0
//            self.layer.masksToBounds = false
//            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
            
//            self.layer.shadowColor = UIColor.black.cgColor
//            self.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
//            self.layer.shadowRadius = 2.0
//            self.layer.shadowOpacity = 0.5
//            self.layer.masksToBounds = true
//            self.layer.shadowPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.contentView.layer.cornerRadius).cgPath
            
            
    }
    
}

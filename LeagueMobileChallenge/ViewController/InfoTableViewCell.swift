//
//  InfoTableViewCell.swift
//  LeagueMobileChallenge
//
//  Created by Gurpreet Kaur on 24/02/23.
//  Copyright © 2023 Kelvin Lau. All rights reserved.
//

import UIKit

class InfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var username: UILabel!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var bodyLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
           super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        avatarImage.layer.cornerRadius = 20
        avatarImage.layer.masksToBounds = true
}
    
    required init?(coder aDecoder: NSCoder) {
       super.init(coder: aDecoder)
    }
    
}


//
//  FeedCellVC.swift
//  ParseStarterProject-Swift
//
//  Created by Vidur Singh on 06/09/16.
//  Copyright © 2016 Parse. All rights reserved.
//

import UIKit

class FeedCellVC: UITableViewCell {

    @IBOutlet weak var postedImg: UIImageView!
    
    @IBOutlet weak var username: UILabel!
    
    @IBOutlet weak var caption: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

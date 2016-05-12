//
//  MessageRootTableViewCell.swift
//  iMessage
//
//  Created by apple on 16/3/18.
//  Copyright © 2016年 apple. All rights reserved.
//

import UIKit

class MessageRootTableViewCell: UITableViewCell {

    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleTestLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

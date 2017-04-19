//
//  TableViewCell.swift
//  FlodTableViewDemo
//
//  Created by 丰雨 on 2017/4/5.
//  Copyright © 2017年 Feng. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.textColor = UIColor.red
        self.contentView.backgroundColor = UIColor.gray
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
}

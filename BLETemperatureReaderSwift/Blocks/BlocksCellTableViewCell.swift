//
//  BlocksCellTableViewCell.swift
//  BLETemperatureReaderSwift
//
//  Created by Douglas Witte on 3/1/18.
//  Copyright © 2018 Cloud City. All rights reserved.
//

import UIKit

class BlocksCellTableViewCell: UITableViewCell
{
    
    @IBOutlet weak var blockImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

//
//  BlockSection.swift
//  BLETemperatureReaderSwift
//
//  Created by Douglas Witte on 2/27/18.
//  Copyright © 2018 Cloud City. All rights reserved.
//

import Foundation
import UIKit

struct BlockSection
{
    var blockTypes: String!
    var blocks: [UIImage]!
    var expanded: Bool!
    
    init(blockTypes: String, blocks: [UIImage]!, expanded: Bool)
    {
        self.blockTypes = blockTypes
        self.blocks = blocks
        self.expanded = expanded
    }
}

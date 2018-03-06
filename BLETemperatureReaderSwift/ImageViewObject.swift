//
//  ImageViewObject.swift
//  BLETemperatureReaderSwift
//
//  Created by Douglas Witte on 3/5/18.
//  Copyright © 2018 Cloud City. All rights reserved.
//

import UIKit

class ImageViewObject: UIImageView
{
    override init(frame: CGRect)
    {
        super.init(frame:frame)
        self.isUserInteractionEnabled = true
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        super.touchesMoved(touches, with: event)
        let touch = touches.first
        self.center = touch!.location(in: self.superview)
    }
}

//
//  ButtonObject.swift
//  BLETemperatureReaderSwift
//
//  Created by 钟佳耘 on 12/11/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import UIKit

class ButtonObject: UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        print("button object class init")
    }
    func viewDidLoad(){
        self.addTarget(self, action: Selector("pressed:"), for: .touchUpInside)
        print("here")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func pressed(){
        print("button was clicked");
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch = touches.first
        self.center = touch!.location(in: self.superview)
    }
   
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

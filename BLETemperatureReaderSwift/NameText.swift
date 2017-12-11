//
//  NameText.swift
//  BLETemperatureReaderSwift
//
//  Created by 钟佳耘 on 12/11/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import UIKit

class NameText: UITextView, UITextViewDelegate {
     //@IBOutlet weak var exampleTextView: UITextView!
    
    override init(frame: CGRect,textContainer: NSTextContainer?){
        super.init(frame: frame, textContainer: textContainer)
      //  self.exampleTextView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch = touches.first
        self.center = touch!.location(in: self.superview)
    }
    
  /*  func textViewDidBeginEditing(_ textView: UITextView) {
        print("exampleTextView: BEGIN EDIT")
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("exampleTextView: END EDIT")
    }*/
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

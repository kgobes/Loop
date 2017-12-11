//
//  DragDropViewController.swift
//  BLETemperatureReaderSwift
//
//  Created by 钟佳耘 on 12/10/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import UIKit

class DragDropViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     @IBAction func objectAdded(theButton:UIButton){
        if theButton.titleLabel?.text == "Meet a friend"{
            var frame = CGRect(x: 30, y: 150, width: 150, height: 30)
            let newView = NameText(frame: frame, textContainer:nil)
            frame = CGRect(x: 30, y: 180, width: 100, height: 30)
            let newTwoView = NameText(frame:frame,textContainer: nil)
            newView.backgroundColor = UIColor.yellow
            newView.text = "If meet   "
            newTwoView.backgroundColor = UIColor.yellow
            newTwoView.text = "Then"
            newView.contentMode = .scaleAspectFit
            newTwoView.contentMode = .scaleAspectFit
            self.view.addSubview(newView)
            self.view.addSubview(newTwoView)
        }else if theButton.titleLabel?.text == "Change LED color"{
            let frame = CGRect(x: 30, y: 210, width: 200, height: 30)
            let newView = NameText(frame: frame, textContainer:nil)
            newView.backgroundColor = UIColor.magenta
            newView.text = "Turn LED color to    "
            newView.contentMode = .scaleAspectFit
            self.view.addSubview(newView)
        }
        
    }

    
}

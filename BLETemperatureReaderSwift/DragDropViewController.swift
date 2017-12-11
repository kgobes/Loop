//
//  DragDropViewController.swift
//  BLETemperatureReaderSwift
//
//  Created by 钟佳耘 on 12/10/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import UIKit

class DragDropViewController: UIViewController{
    
    //init(){
        var frame1 = CGRect(x: 30, y: 150, width: 150, height: 30)
        var frame2 = CGRect(x: 30, y: 180, width: 100, height: 30)
        var frame3 = CGRect(x: 30, y: 250, width: 100, height: 200)
        var ifNearBlock = NameText();
        var thenBlock = NameText();
   /* }
    required init(coder decoder: NSCoder) {
        super.init(coder: decoder)
    }*/
    
    //@IBOutlet weak var colorPicker: UIPickerView!
   
    
    
    //colorPicker.isHidden = true;
    
    @IBOutlet weak var nearFriendButton: UIButton!
    
    @IBAction func nearFriendButtonEdit(_ sender: Any) {
        print("edited the button")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
     @IBAction func objectAdded(theButton:UIButton){
        //if the Meet a friend button is clicked
        if theButton.titleLabel?.text == "Meet a friend"{
            //frame = CGRect(x: 30, y: 150, width: 150, height: 30)
            ifNearBlock = NameText(frame: frame1, textContainer:nil)
            //frame = CGRect(x: 30, y: 180, width: 100, height: 30)
            thenBlock = NameText(frame:frame2,textContainer: nil)
            ifNearBlock.backgroundColor = UIColor.yellow
            ifNearBlock.text = "If meet   "
            thenBlock.backgroundColor = UIColor.yellow
            thenBlock.text = "Then"
            ifNearBlock.contentMode = .scaleAspectFit
            thenBlock.contentMode = .scaleAspectFit
            self.view.addSubview(ifNearBlock)
            self.view.addSubview(thenBlock)
            SecondViewController().nearFriendAdded(ifNearBlock: ifNearBlock)
            var colorPicker = PickerView(frame:frame3)
            colorPicker.isUserInteractionEnabled = true

            //colorPicker.PickerView(pickerView: colorPicker, titleForRow: "cat", forComponent: <#T##Int#>)

            colorPicker.contentMode = .scaleAspectFit
            self.view.addSubview(colorPicker)
            //colorPicker.isHidden = true;
            //colorPicker = PickerView(frame1, frame1)
           // nearFriendAdded(<#T##SecondViewController#>)
            
            //NameText.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
            
        }
        else if theButton.titleLabel?.text == "Change LED color"{
            let frame = CGRect(x: 30, y: 210, width: 200, height: 30)
            let changeColorBlock = NameText(frame: frame, textContainer:nil)
            changeColorBlock.backgroundColor = UIColor.magenta
            changeColorBlock.text = "Turn LED color to    "
            changeColorBlock.contentMode = .scaleAspectFit
            self.view.addSubview(changeColorBlock)
        }
        else if theButton.titleLabel?.text == "Add Friend: Michelle"{
            print("michelle added")
        }
        
    }

    
}

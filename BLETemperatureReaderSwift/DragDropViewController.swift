//
//  DragDropViewController.swift
//  BLETemperatureReaderSwift
//
//  Created by 钟佳耘 on 12/10/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import UIKit

class DragDropViewController: UIViewController{
    var ifNearBlock = LableObject();
    var thenBlock = LableObject();
    var colorPicker = PickerView();
    var friendPicker = PickerView();
    var changeName = UIButton();
    var changeColor = UIButton();
    var nameChangeClicked = false;
    var colorChangeClicked = false;
    
    
    //BOOLEANS to test if blocks have been created yet
    var ifNearBool = false;
    var changeLEDBool = false;
    var nameOfFriendBool = false;
    var friendChosenBool = false;
    var colorBlockBool = false;
    var colorChosenBool = false;
    
    
    @IBOutlet weak var saveButton: UIButton!
    
    @IBOutlet weak var nearFriendButton: UIButton!
    

    @IBAction func saveButtonClicked(_ sender: Any) {
        print("save button clicked");
        var color = colorPicker.getSelectedRow();
        SecondViewController().nearFriendAdded(color: color)
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
        //if near friend button is clicked
        if theButton.titleLabel?.text == "If Near... Then"{
            ifNearBool = true;
            var frameIfNear = CGRect(x: 15, y: 180, width: 100, height: 50)
            ifNearBlock = LableObject(frame: frameIfNear)
            var frameThen = CGRect(x: 15, y: 230, width: 100, height: 50)
            thenBlock = LableObject(frame:frameThen)
            ifNearBlock.backgroundColor = UIColor.yellow
            ifNearBlock.text = "If near:  "
            thenBlock.backgroundColor = UIColor.yellow
            thenBlock.text = "Then:   "
            ifNearBlock.contentMode = .scaleAspectFit
            thenBlock.contentMode = .scaleAspectFit
            self.view.addSubview(ifNearBlock)
            self.view.addSubview(thenBlock)
        }
        else if theButton.titleLabel?.text == "Change LED color"{
            changeLEDBool = true;
            let frame = CGRect(x: 15, y: 300, width: 200, height: 50)
            let changeColorBlock = LableObject(frame: frame)
            changeColorBlock.backgroundColor = UIColor.magenta
            changeColorBlock.text = "Turn LED color to    "
            changeColorBlock.contentMode = .scaleAspectFit
            self.view.addSubview(changeColorBlock)
        }
            
        else if theButton.titleLabel?.text == "Name of Friend"{
            nameOfFriendBool = true;
            let frame4 = CGRect(x: 115, y: 180, width: 200, height: 30)
            
            changeName = UIButton(frame: frame4)
            changeName.backgroundColor = UIColor(hue: 0.5222, saturation: 0.52, brightness: 0.96, alpha: 1.0)
             changeName.setTitle("Click to select friend", for: .normal)
            changeName.addTarget(self, action: #selector(pressedFriendButton), for: .touchUpInside)
            changeName.addTarget(self,
                             action: #selector(drag(control:event:)),
                             for: UIControlEvents.touchDragInside)
            changeName.addTarget(self,
                             action: #selector(drag(control:event:)),
                             for: [UIControlEvents.touchDragExit,
                                   UIControlEvents.touchDragOutside])
            changeName.setTitleColor(.black, for: .normal)
            self.view.addSubview(changeName)
            var frameFriendPicker = CGRect(x: 215, y: 120, width: 250, height: 150)
            friendPicker = PickerView(frame:frameFriendPicker)
            friendPicker.isUserInteractionEnabled = true
            friendPicker.contentMode = .scaleAspectFit
    
        }
        
        
        else if theButton.titleLabel?.text == "Color"{
            colorBlockBool = true;
            let frameColor = CGRect(x: 25, y: 300, width: 250, height: 30)
            changeColor = UIButton(frame: frameColor)
            changeColor.setTitle("Click to change color", for: .normal)
            changeColor.backgroundColor = UIColor(hue: 0.3083, saturation: 0.71, brightness: 0.94, alpha: 1.0)
            changeColor.setTitleColor(.black, for: .normal)
            changeColor.contentMode = .scaleAspectFit
            changeColor.addTarget(self, action: #selector(pressedColorButton), for: .touchUpInside)
            changeColor.addTarget(self,
                                 action: #selector(drag(control:event:)),
                                 for: UIControlEvents.touchDragInside)
            changeColor.addTarget(self,
                                 action: #selector(drag(control:event:)),
                                 for: [UIControlEvents.touchDragExit,
                                       UIControlEvents.touchDragOutside])
            self.view.addSubview(changeColor)
            var frameColorPicker = CGRect(x: 200, y: 150, width: 300, height: 200)
            colorPicker = PickerView(frame:frameColorPicker)
            colorPicker.isUserInteractionEnabled = true
            colorPicker.contentMode = .scaleAspectFit
        }
        
    }
    
    func pressedFriendButton(){
        if(!nameChangeClicked){
            friendPicker.isHidden = false; //make picker visible
            nameChangeClicked = true;
            //add friend picker
            self.view.addSubview(friendPicker)
            changeName.setTitle("Tap to select name", for: .normal)
        }
        else{
            friendChosenBool = true;
            friendPicker.isHidden = true; //hide picker
            changeName.setTitle("name here", for: .normal);
            nameChangeClicked = false;
            //changeName.setTitle("Tap to select name", for: .normal)
        }
    }
    
    
    func pressedColorButton(){
        if(!colorChangeClicked){
            colorPicker.isHidden = false; //make picker visible
            colorChangeClicked = true;
            //add color picker
            self.view.addSubview(colorPicker)
            changeColor.setTitle("Tap to select color", for: .normal)
        }
        else{
            colorChosenBool = true;
            colorPicker.isHidden = true; //hide picker
            changeColor.setTitle("color here", for: .normal);
            colorChangeClicked = false;
        }
    }
    //override function to make button draggable
    func drag(control: UIControl, event: UIEvent) {
        if let center = event.allTouches?.first?.location(in: self.view) {
            control.center = center
        }
    }
   
    
}

//
//  DragDropViewController.swift
//  BLETemperatureReaderSwift
//
//  Created by 钟佳耘 on 12/10/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import UIKit

class DragDropViewController: UIViewController{
    
    //bluetooth object for bracelet
    let bluetooth = BluetoothHandler()
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
    
    //important values to send to code
    var colorToChangeTo = "blue";
    var friendA = "DefaultFriend";
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nearFriendButton: UIButton!
    
    
    override func viewDidLoad() {
        bluetooth.startManager()
        super.viewDidLoad()
    }
    
    
    override func didReceiveMemoryWarning()
    {super.didReceiveMemoryWarning()}
    
    
     @IBAction func objectAdded(theButton:UIButton){
        
        //if near friend button is clicked
        if theButton.titleLabel?.text == "If Near... Then"{
            ifNearBool = true;
            //create ifnear and then block
            var frameIfNear = CGRect(x: 15, y: 180, width: 100, height: 50)
            ifNearBlock = LableObject(frame: frameIfNear)
            var frameThen = CGRect(x: 15, y: 230, width: 100, height: 50)
            thenBlock = LableObject(frame:frameThen)
            //set ifnear and then block
            ifNearBlock.backgroundColor = UIColor.yellow
            ifNearBlock.text = "If near:  "
            thenBlock.backgroundColor = UIColor.yellow
            thenBlock.text = "Then:   "
            ifNearBlock.contentMode = .scaleAspectFit
            thenBlock.contentMode = .scaleAspectFit
            self.view.addSubview(ifNearBlock)
            self.view.addSubview(thenBlock)
        }
        //if change LED color button is clicked
        else if theButton.titleLabel?.text == "Change LED color"{
            changeLEDBool = true;
            //create change LED color block
            let frame = CGRect(x: 15, y: 300, width: 200, height: 50)
            let changeColorBlock = LableObject(frame: frame)
            changeColorBlock.backgroundColor = UIColor.magenta
            changeColorBlock.text = "Turn LED color to    "
            changeColorBlock.contentMode = .scaleAspectFit
            self.view.addSubview(changeColorBlock)
        }
        //if name of friend button is clicked
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
            //friendPicker = UIPickerView() as! PickerView
            //friendPicker.frame = frameFriendPicker
           // friendPicker.delegate = self as! UIPickerViewDelegate
           // friendPicker.dataSource = self as! UIPickerViewDataSource
            friendPicker = PickerView(frame:frameFriendPicker)
            friendPicker.setPickerType(typeOfPicker: 2)
            //self.view.addSubview(friendPicker)
            friendPicker.isUserInteractionEnabled = true
            friendPicker.contentMode = .scaleAspectFit
        }
        //if "color" button is clicked
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
            var frameColorPicker = CGRect(x: 0, y: 550, width: 100, height: 150)
            colorPicker = PickerView(frame:frameColorPicker)
            colorPicker.setPickerType(typeOfPicker: 1);
            colorPicker.isUserInteractionEnabled = true
            colorPicker.contentMode = .scaleAspectFit
        }
    }
    
    
    @IBAction func saveButtonClicked(_ sender: Any) {
        
        print("save button clicked");
        
        //checkConditions()
        print(checkConditions())
        print(colorToChangeTo);
        
        // bluetooth.startManager()
        bluetooth.updateLEDs(color: colorToChangeTo)
    }
    
    
    func pressedFriendButton(){
        print("in friend button method");
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
            friendA = friendPicker.getSelectedRow();
            changeName.setTitle(friendA, for: .normal);
            nameChangeClicked = false;
            //changeName.setTitle("Tap to select name", for: .normal)
        }
    }
    
    
    func pressedColorButton(){
        print("in changed color");
        if(!colorChangeClicked){
            print("in if in change color");
            colorPicker.isHidden = false; //make picker visible
            colorChangeClicked = true;
            //add color picker
            self.view.addSubview(colorPicker)
            changeColor.setTitle("Tap to select color", for: .normal)
        }
        else{
            print("in else");
            colorChosenBool = true;
            colorPicker.isHidden = true; //hide picker
            colorToChangeTo = colorPicker.getSelectedRow();
            print("color changed to ", colorToChangeTo);
            print("getting status")
            print(getStatus());
            changeColor.setTitle(colorToChangeTo, for: .normal);
            colorChangeClicked = false;
        }
    }
    
    
    //override function to make button draggable
    func drag(control: UIControl, event: UIEvent) {
        if let center = event.allTouches?.first?.location(in: self.view) {
            control.center = center
        }
    }
    
    
    func checkConditions() -> Bool{
        if(colorChosenBool && friendChosenBool && ifNearBool && changeLEDBool && colorBlockBool && nameOfFriendBool){
            return true;
        }
        else{
            return false;
        }
    }
    
    
    //color not updating here, not sure why yet
    func getStatus()-> String{
        print(colorToChangeTo);
        return colorToChangeTo;
    }
    
//PICKER VIEW functions
}

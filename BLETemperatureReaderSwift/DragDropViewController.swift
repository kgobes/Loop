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
    
    var testingControlBlock = ImageViewObject(frame: CGRect(x: 20, y: 0, width: 0, height: 0));
    
    //BOOLEANS to test if blocks have been created yet
    var ifNearBool = false;
    var changeLEDBool = false;
    var nameOfFriendBool = false;
    var friendChosenBool = false;
    var colorBlockBool = false;
    
    //currently in use 3/7
    var colorChosenBool = false;
    var actionLEDchosen = false;
    var controlBlock = false;
    var friendChosen = false;
    var nearFriendBlock = false;
    var lookForFriend = false;
    
    //important values to send to code
    var colorToChangeTo = "blue";
    var friendA = "DefaultFriend";
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nearFriendButton: UIButton!
    
    
    override func viewDidLoad() {
        bluetooth.startManager()
        super.viewDidLoad()
        print("DragDropViewController loaded")
        printXCoordinate()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {print("DragDropViewController appeared")}
    
    
    override func didReceiveMemoryWarning()
    {super.didReceiveMemoryWarning()}
    
    func printXCoordinate()
    {
        print(testingControlBlock.frame.origin.x)
    }
    
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
    
    
    
    func objectAddedFromTable(tappedBlock: String){
        //if near friend button is clicked
        if tappedBlock == "If Near... Then"{
            print("PRINTED FROM OAFT")
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
            print("PRINTED AFTER ADD")
        }
            //if change LED color button is clicked
        else if tappedBlock == "Change LED color"{
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
        else if tappedBlock == "Name of Friend"{
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
        else if tappedBlock == "Color"{
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
        else
        {
            print("else statement")
        }
    }
    
    
    
    @IBAction func uploadButtonClicked(_ sender: Any)
    {
        print("upload button clicked");
        
         print(checkConditions())
         //checkConditions()
       
        print(colorToChangeTo);
        
    
        if(checkConditions() && lookForFriend){
            bluetooth.keepScanning = true;
            bluetooth.centralManager.scanForPeripherals(withServices: nil, options: nil)
            //bluetooth.startManager()
            //bluetooth.resumeScan()
        }
        else if(checkConditions()){
            print("going to update LEDs...");
            bluetooth.updateLEDs(color: colorToChangeTo)
        }
    }
    
    
    
    @IBAction func openBlockListVC(_ sender: Any)
    {
        print("open blocklistVC")
        performSegue(withIdentifier: "goRight", sender: self)
        print("yabadoo")
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
        if(colorChosenBool && actionLEDchosen && controlBlock && friendChosen && nearFriendBlock){
            print("conditions for find friend met");
            lookForFriend = true;
            //bluetooth.centralManager.scanForPeripherals(withServices: nil, options: nil)
            //set variable
            return true;
        }
        else if(colorChosenBool && actionLEDchosen){
            print("valid conditions met for changing LED");
            return true;
        }
        else{
            return false;
        }
        
        
        /*Original version:
         
         if(colorChosenBool && friendChosenBool && ifNearBool && changeLEDBool && colorBlockBool && nameOfFriendBool){
            return true;
        }
        else{
            return false;
        }*/
    }
    
    
    //color not updating here, not sure why yet
    func getStatus()-> String{
        print(colorToChangeTo);
        return colorToChangeTo;
    }
    
    
//PICKER VIEW functions
}



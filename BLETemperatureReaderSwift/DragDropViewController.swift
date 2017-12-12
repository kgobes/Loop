//
//  DragDropViewController.swift
//  BLETemperatureReaderSwift
//
//  Created by 钟佳耘 on 12/10/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import UIKit

class DragDropViewController: UIViewController{
    var frame1 = CGRect(x: 30, y: 150, width: 100, height: 30)
    var frame2 = CGRect(x: 30, y: 180, width: 80, height: 30)
    var frame3 = CGRect(x: 50, y: 450, width: 300, height: 200)
    var ifNearBlock = LableObject();
    var thenBlock = LableObject();
    var colorPicker = PickerView();
    var friendPicker = PickerView();
    var changeName = UIButton();
    var nameChangeClicked = false;
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
        //if the Meet a friend button is clicked
        if theButton.titleLabel?.text == "Meet a friend"{
            //frame = CGRect(x: 30, y: 150, width: 150, height: 30)
            ifNearBlock = LableObject(frame: frame1)
            //frame = CGRect(x: 30, y: 180, width: 100, height: 30)
            thenBlock = LableObject(frame:frame2)
            ifNearBlock.backgroundColor = UIColor.yellow
            ifNearBlock.text = "If meet   "
            thenBlock.backgroundColor = UIColor.yellow
            thenBlock.text = "Then"
            ifNearBlock.contentMode = .scaleAspectFit
            thenBlock.contentMode = .scaleAspectFit
            self.view.addSubview(ifNearBlock)
            self.view.addSubview(thenBlock)
            
            
            //NameText.addTarget(self, action: "textFieldDidChange:", forControlEvents: UIControlEvents.EditingChanged)
            
        }
        else if theButton.titleLabel?.text == "Change LED color"{
            let frame = CGRect(x: 30, y: 100, width: 200, height: 50)
            let changeColorBlock = LableObject(frame: frame)
            changeColorBlock.backgroundColor = UIColor.magenta
            changeColorBlock.text = "Turn LED color to    "
            changeColorBlock.contentMode = .scaleAspectFit
            self.view.addSubview(changeColorBlock)
        }
            
        else if theButton.titleLabel?.text == "Name of friend"{
            let frame4 = CGRect(x: 30, y: 380, width: 300, height: 30)
            
            changeName = UIButton(frame: frame4)
            changeName.backgroundColor = UIColor.blue
             changeName.setTitle("Click to change name", for: .normal)
            changeName.addTarget(self, action: #selector(pressedButton), for: .touchUpInside)
            changeName.setTitleColor(.black, for: .normal)
            self.view.addSubview(changeName)
            
           /* let changeName = ButtonObject(frame:frame)
            changeName.backgroundColor = UIColor.yellow
            changeName.setTitleColor(.black, for: .normal)
            changeName.setTitle("Click to change name", for: .normal)
//            changeName.addTarget(self, action: "pressed:", for: .touchUpInside)
            changeName.contentMode = .scaleAspectFit
           // self.isUserInteratctionEnabled = true
            self.view.addSubview(changeName)
            */
    
        }
        
        
        /*else if theButton.titleLabel?.text == "Color"{
            let frame = CGRect(x: 30, y: 300, width: 300, height: 30)
            let changeColor = ButtonObject(frame:frame)
            changeColor.setTitle("Click to change color", for: .normal)
            changeColor.backgroundColor = UIColor.yellow
            changeColor.setTitleColor(.black, for: .normal)
            changeColor.contentMode = .scaleAspectFit
            self.view.addSubview(changeColor)
            
            //add color choices
            colorPicker = PickerView(frame:frame3)
            colorPicker.isUserInteractionEnabled = true
            colorPicker.contentMode = .scaleAspectFit
            self.view.addSubview(colorPicker)
        }*/
        
    }
    func pressedButton(){
        if(!nameChangeClicked){
            nameChangeClicked = true;
            print("button pressed");
            //add friend picker
            friendPicker = PickerView(frame:frame3)
            friendPicker.isUserInteractionEnabled = true
            friendPicker.contentMode = .scaleAspectFit
            self.view.addSubview(friendPicker)
            changeName.setTitle("Tap to select name", for: .normal)
        }
        else{
           // nameChangeClicked = false;
            //changeName.setTitle("Tap to select name", for: .normal)
        }
    }
    /*
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch = touches.first
        self.center = touch!.location(in: self.superview)
    }*/
    
}

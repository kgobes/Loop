//
//  PickerView.swift
//  BLETemperatureReaderSwift
//
//  Created by Kira Gobes's Mac on 12/11/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import UIKit

class PickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    var selectedRow = "temp select";
    var colorPicker = false; //1
    var friendPicker = false; //2
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        self.delegate = self;
        self.dataSource = self;
        
        //self.isHidden = false;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setPickerType(typeOfPicker: Int){
        if(typeOfPicker == 1){
            colorPicker = true;
        }
        else if(typeOfPicker == 2){
            friendPicker = true;
        }
    }
    let colors = ["red", "blue", "green", "rainbow"]
    let friends = ["Michelle", "Kelsie", "Vibhor", "Kira"]
    //let friends = BluetoothHandler.getFriends();
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if(colorPicker){
            return colors[row]
        }
        else if(friendPicker){
            return friends[row]
        }
        else{
            return "error";
        }
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if(colorPicker){
            return colors.count
        }
        else if(friendPicker){
            return friends.count
        }
        else{ //error
            return 1;
        }
    }
    //when stopped on one color
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        //selectedRow = colors[row]
        if(colorPicker){
            selectedRow = colors[row]
        }
        else if(friendPicker){
            selectedRow = friends[row]
        }
        else{ //error
            selectedRow = "error";
        }
    }

    //return current selection
    func getSelectedRow() -> String{
        return selectedRow;
    }
    
  
}

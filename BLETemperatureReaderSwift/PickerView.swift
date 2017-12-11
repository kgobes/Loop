//
//  PickerView.swift
//  BLETemperatureReaderSwift
//
//  Created by Kira Gobes's Mac on 12/11/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import UIKit

class PickerView: UIPickerView, UIPickerViewDataSource, UIPickerViewDelegate {
    var selectedRow = "temp color"
    override init(frame: CGRect) {
        print("init picker view")
        super.init(frame:frame)
        self.delegate = self;
        self.dataSource = self;
        
        //self.isHidden = false;
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    let colors = ["red", "blue", "green"]
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return colors[row]
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return colors.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        print("color selected")
        selectedRow = colors[row]
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        let touch = touches.first
        self.center = touch!.location(in: self.superview)
    }
    func getSelectedRow() -> String{
        return selectedRow;
    }
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}

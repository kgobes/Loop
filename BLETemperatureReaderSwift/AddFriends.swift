//
//  AddFriends.swift
//  BLETemperatureReaderSwift
//
//  Created by Kira Gobes's Mac on 12/15/17.
//  Copyright © 2017 Cloud City. All rights reserved.
//

import UIKit

class AddFriends: UIViewController {
    let bluetooth = BluetoothHandler();
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in friends class")
        
        bluetooth.startManager();

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var friendToAdd: UITextField!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func searchForFriend(_ sender: Any) {
        var friend: String = friendToAdd.text!
        print("in search method. Connecting to BT")
        bluetooth.friendSearch(friendName: friend);
    }
    

}

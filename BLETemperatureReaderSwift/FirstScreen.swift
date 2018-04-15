//
//  FirstScreen.swift
//  BLETemperatureReaderSwift
//
//  Created by 钟佳耘 on 4/15/18.
//  Copyright © 2018 Cloud City. All rights reserved.
//

import UIKit

class FirstScreen: UIViewController {
    @IBOutlet weak var welcomeLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let name = UserDefaults.standard.value(forKey: "name"){
        welcomeLabel.text = "Welcome, \(name) !"
        }

        // Do any additional setup after loading the view.
    }
        

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  OnboardingVC.swift
//  BLETemperatureReaderSwift
//
//  Created by 钟佳耘 on 4/14/18.
//  Copyright © 2018 Cloud City. All rights reserved.
//

import UIKit

class OnboardingVC: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func continueTouched(_ sender: UIButton) {
        UserDefaults.standard.set(nameTextField.text, forKey: "name")
        performSegue(withIdentifier: "toMainSegue", sender: self)
    }
    

}

//
//  BlockListViewController.swift
//  BLETemperatureReaderSwift
//
//  Created by Douglas Witte on 2/27/18.
//  Copyright © 2018 Cloud City. All rights reserved.
//

import UIKit

class BlockListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        print("Reached BlockListViewController")
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
    }

    override func didReceiveMemoryWarning() {super.didReceiveMemoryWarning()}
    
    func swipeAction(swipe: UISwipeGestureRecognizer)
    {
        switch swipe.direction
        {
        case UISwipeGestureRecognizerDirection.right:
            self.dismiss(animated: true, completion: nil)
            print("dismissing")
        default:
            print("break statement")
            break
        }
    }
}

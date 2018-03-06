//
//  BlockListViewController.swift
//  BLETemperatureReaderSwift
//
//  Created by Douglas Witte on 2/27/18.
//  Copyright © 2018 Cloud City. All rights reserved.
//

import UIKit

class BlockListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, ExpandableHeaderViewDelegate
{
    var ifNearBlock = LableObject();
    var thenBlock = LableObject();
    var changeName = UIButton();
    var friendPicker = PickerView();
    
    @IBOutlet weak var blockListTableView: UITableView!
    
    @IBAction func buttonClicked(_ sender: Any) {
        print("button has been clicked")
        self.dismiss(animated: true, completion: nil)
    }
    //Array of BlockSections - a struct defined in BlockSection.swift
    var sections =
    [
        BlockSection(blockTypes: "Triggers",
                     blocks: [#imageLiteral(resourceName: "nearFriends.png")],
                     expanded: false),
        BlockSection(blockTypes: "Actions",
                     blocks: [#imageLiteral(resourceName: "actionVibrate.png"), #imageLiteral(resourceName: "actionLEDs.png")],
                     expanded: false),
        BlockSection(blockTypes: "Controls",
                     blocks: [#imageLiteral(resourceName: "control.png")],
                     expanded: false),
        BlockSection(blockTypes: "Properties",
                     blocks: [#imageLiteral(resourceName: "property4Seconds.png"), #imageLiteral(resourceName: "property3Seconds.png"), #imageLiteral(resourceName: "property2Seconds.png"), #imageLiteral(resourceName: "property1Second.png"), #imageLiteral(resourceName: "propertyHalfSecond.png"), #imageLiteral(resourceName: "propertySam.png"), #imageLiteral(resourceName: "propertyMichelle.png"), #imageLiteral(resourceName: "propertyKira.png"), #imageLiteral(resourceName: "propertyChris.png"), #imageLiteral(resourceName: "propertyVibhor.png"), #imageLiteral(resourceName: "propertyRed.png"), #imageLiteral(resourceName: "propertyBlue.png"), #imageLiteral(resourceName: "propertyGreen.png"), #imageLiteral(resourceName: "propertyYellow.png")],
                     expanded: false)
    ]

    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        print("Reached BlockListViewController")
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(swipe:)))
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        self.blockListTableView.separatorStyle = .none
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
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        if indexPath.section == 0
        {
            DispatchQueue.main.async
            {
                if let presenter = self.presentingViewController as? DragDropViewController
                {
                    presenter.ifNearBool = true;
                    //create block
                    var frameNearFriends = CGRect(x: 15, y: 180, width: 150, height: 30)
                    let nearFriendsBlock = ImageViewObject(frame: frameNearFriends)
//                    self.nearFriendsBlock.contentMode = .scaleAspectFit
                    nearFriendsBlock.image = #imageLiteral(resourceName: "nearFriends.png")
//                    self.nearFriendsBlock.backgroundColor = UIColor.blue
                    presenter.view.addSubview(nearFriendsBlock)
                }
                self.dismiss(animated: true, completion: nil)
                print("after dispatch")
            }
        }
        else if indexPath.section == 1
        {
            DispatchQueue.main.async
            {
                if let presenter = self.presentingViewController as? DragDropViewController
                {
                    presenter.changeLEDBool = true;
                    //create change LED color block
                    let actionFrame = CGRect(x: 15, y: 300, width: 225, height: 75)
                    let actionsBlock = ImageViewObject(frame: actionFrame)
                    
                    if indexPath.row == 0
                    {
                        actionsBlock.image = #imageLiteral(resourceName: "actionVibrate.png")
                    }
                    else
                    {
                        actionsBlock.image = #imageLiteral(resourceName: "actionLEDs.png")
                    }
                    
//                    changeColorBlock.contentMode = .scaleAspectFit
                    presenter.view.addSubview(actionsBlock)
                }
                self.dismiss(animated: true, completion: {print("second section tapped")})
                print("after dispatch")
            }
        }
        else if indexPath.section == 2
        {
            DispatchQueue.main.async
            {
                if let presenter = self.presentingViewController as? DragDropViewController
                {
                    presenter.nameOfFriendBool = true;
                    let controlFrame = CGRect(x: 115, y: 180, width: 300, height: 125)
                    let controlBlock = ImageViewObject(frame: controlFrame)
                    controlBlock.image = #imageLiteral(resourceName: "control.png")
                    presenter.view.addSubview(controlBlock)
                }
                self.dismiss(animated: true, completion: nil)
                print("after dispatch")
            }
        }
        else
        {
            DispatchQueue.main.async
            {
                if let presenter = self.presentingViewController as? DragDropViewController
                {
                    presenter.colorBlockBool = true;
                    let propertyFrame = CGRect(x: 15, y: 300, width: 75, height: 25)
                    let propertyBlock = ImageViewObject(frame: propertyFrame)
                    
                    if indexPath.row == 0
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "property4Seconds.png")
                    }
                    else if indexPath.row == 1
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "property3Seconds.png")
                    }
                    else if indexPath.row == 2
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "property2Seconds.png")
                    }
                    else if indexPath.row == 3
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "property1Second.png")
                    }
                    else if indexPath.row == 4
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "propertyHalfSecond.png")
                    }
                    else if indexPath.row == 5
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "propertySam.png")
                    }
                    else if indexPath.row == 6
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "propertyMichelle.png")
                    }
                    else if indexPath.row == 7
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "propertyKira.png")
                    }
                    else if indexPath.row == 8
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "propertyChris.png")
                    }
                    else if indexPath.row == 9
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "propertyVibhor.png")
                    }
                    else if indexPath.row == 10
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "propertyRed.png")
                    }
                    else if indexPath.row == 11
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "propertyBlue.png")
                    }
                    else if indexPath.row == 12
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "propertyGreen.png")
                    }
                    else if indexPath.row == 13
                    {
                        propertyBlock.image = #imageLiteral(resourceName: "propertyYellow.png")
                    }
                    else
                    {
                        print("should not reach, just testing")
                    }
//                    changeColorBlock.contentMode = .scaleAspectFit
                    presenter.view.addSubview(propertyBlock)
                }
                self.dismiss(animated: true, completion: nil)
                print("after dispatch")
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].blocks.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "labelCell") as! BlocksCellTableViewCell
        cell.blockImage.image = sections[indexPath.section].blocks[indexPath.row]
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int
    {return sections.count}
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat
    {return 50}
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (sections[indexPath.section].expanded)
        {return 50}
        else
        {return 0}
    }
    
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat
    {return 2}
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = ExpandableHeaderView()
        header.customInit(title: sections[section].blockTypes, section: section, delegate: self)
        return header
    }
    
    
    func toggleSection(header: ExpandableHeaderView, section: Int)
    {
        sections[section].expanded = !sections[section].expanded
        
        blockListTableView.beginUpdates()
        for i in 0..<sections[section].blocks.count
        {
            blockListTableView.reloadRows(at: [IndexPath(row: i, section: section)], with: .automatic)
        }
        blockListTableView.endUpdates()
    }
}

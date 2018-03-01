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
    @IBOutlet weak var blockListTableView: UITableView!
    
    @IBAction func buttonClicked(_ sender: Any) {
        print("button has been clicked")
        self.dismiss(animated: true, completion: nil)
    }
    //Array of BlockSections - a struct defined in BlockSection.swift
    var sections =
    [
        BlockSection(blockTypes: "Triggers",
                     blocks: [#imageLiteral(resourceName: "propertySam.png"), #imageLiteral(resourceName: "propertyMichelle.png"), #imageLiteral(resourceName: "controlNearFriend.png"), #imageLiteral(resourceName: "propertyKira.png"), #imageLiteral(resourceName: "propertyChris.png"), #imageLiteral(resourceName: "propertyVibhor.png")],
                     expanded: false),
        BlockSection(blockTypes: "Actions",
                     blocks: [#imageLiteral(resourceName: "actionVibrate.png"), #imageLiteral(resourceName: "actionLEDs.png")],
                     expanded: false),
        BlockSection(blockTypes: "Controls",
                     blocks: [#imageLiteral(resourceName: "propertyRed.png"), #imageLiteral(resourceName: "propertyBlue.png")],
                     expanded: false),
        BlockSection(blockTypes: "Properties",
                     blocks: [#imageLiteral(resourceName: "propertyGreen.png"), #imageLiteral(resourceName: "propertyGreen.png")],
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
        let myDragDrop = DragDropViewController()
        if indexPath.section == 0
        {
            DispatchQueue.main.async
            {
                //upon completion, I need to add the block to DragDropViewController
                self.dismiss(animated: true, completion: {myDragDrop.objectAddedFromTable(tappedBlock: "If Near... Then")})
                print("after dispatch")
            }
        }
        else if indexPath.section == 1
        {
            DispatchQueue.main.async
            {
                self.dismiss(animated: true, completion: nil)
                print("after dispatch")
            }
        }
        else if indexPath.section == 2
        {
            DispatchQueue.main.async
            {
                self.dismiss(animated: true, completion: nil)
                print("after dispatch")
            }
        }
        else
        {
            DispatchQueue.main.async
            {
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

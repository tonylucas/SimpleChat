//
//  ViewController.swift
//  SimpleChat
//
//  Created by Tony Lucas on 13/02/2015.
//  Copyright (c) 2015 Tony Lucas. All rights reserved.
//

import UIKit
import MultipeerConnectivity

let newUserNotification = "AddNewUserNotification"

class ViewController: UITableViewController, MCBrowserViewControllerDelegate {
    
    let appDelegate = AppDelegate.appDelegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: "userInsert:", name: newUserNotification, object: nil)
    }
    
    
    func userInsert(notification: NSNotification){
        println("userInsert")
        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    }
    
    
    @IBAction func inviteAction(sender: UIButton) {
        
        if let session = AppDelegate.sharedSession(){
            let browserViewController = MCBrowserViewController(serviceType: serviceType, session: appDelegate.session)
            browserViewController.delegate = self
            
            presentViewController(browserViewController, animated: true, completion: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func browserViewControllerDidFinish(browserViewController: MCBrowserViewController!){
        println("browserViewControllerDidFinish")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func browserViewControllerWasCancelled(browserViewController: MCBrowserViewController!) {
        println("browserViewControllerWasCancelled")
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return appDelegate.users.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let peerID = appDelegate.users[indexPath.row] as MCPeerID
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        
//        let peerID = dict["peerID"] as MCPeerID
        
        let name = peerID.displayName
        cell.textLabel!.text = name

        if !(appDelegate.dict[peerID] is NSNull) {
            if let image = appDelegate.dict[peerID] as UIImage? {
                cell.imageView!.image = image as UIImage
            }
        }
        
        return cell
    }
    
    
    
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the specified item to be editable.
        return true
    }
    
    
    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    
    
    
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {
        
    }
    
    
    
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return NO if you do not want the item to be re-orderable.
        return true
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    
}

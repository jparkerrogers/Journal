//
//  EntryTableViewController.swift
//  Journal
//
//  Created by Jonathan Rogers on 3/14/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class EntryTableViewController: UITableViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    
    @IBAction func shuffle(sender: AnyObject) {
        
        
        
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return EntryController.sharedController.entriesArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath)
        
        let entry = EntryController.sharedController.entriesArray[indexPath.row]
        
        let time = NSDate()
        
        let formatter = NSDateFormatter()
        
        formatter.dateFormat = "MM-dd"
        
        let formattedDate = formatter.stringFromDate(time)
        
        cell.textLabel?.text = entry.title
        
        cell.detailTextLabel!.text = formattedDate
        
        if (indexPath.row % 2 == 0) {
            cell.backgroundColor = UIColor.cyanColor()
        } else {
            cell.backgroundColor = UIColor.lightGrayColor()
        }

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let entry = EntryController.sharedController.entriesArray[indexPath.row]
            
            EntryController.sharedController.deleteEntry(entry)
            
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.identifier == "viewEntry" {
            
            let entryDetailViewController = segue.destinationViewController as? EntryDetailViewController
            
            _ = entryDetailViewController!.view
            
            let indexPath = tableView.indexPathForSelectedRow
            
            if let selectedRow = indexPath?.row {
                
                let entry = EntryController.sharedController.entriesArray[selectedRow]
                entryDetailViewController?.updateWith(entry)
                
                
                /// study the second part in depth
                
            }
        }
        
    }
}

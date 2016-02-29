//
//  EntryResultsTableViewController.swift
//  Journal
//
//  Created by Dylan Slade on 2/24/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class EntryResultsTableViewController: UITableViewController {
    
    var filteredEntries = [Entry]()
    
    // MARK: - lolz
    
    override func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        let tappedCell = tableView.cellForRowAtIndexPath(indexPath)
        presentingViewController?.performSegueWithIdentifier("toShowEntry", sender: tappedCell)
    }

    // MARK: - Table view data source
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredEntries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath)
        let entry = filteredEntries[indexPath.row]
        cell.textLabel?.text = entry.title
        return cell
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toShowEntry" {
            let indepxPath = tableView.indexPathForCell(sender as! UITableViewCell)
            let selectedEntry = filteredEntries[indepxPath!.row]
            let entryDetailViewController = segue.destinationViewController as! EntryDetailViewController
            _ = entryDetailViewController.view
            entryDetailViewController.updateWithEntry(selectedEntry)
        }
    }

}
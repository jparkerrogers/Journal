//
//  ListTableViewController.swift
//  Journal
//
//  Created by Caleb Hicks on 10/3/15.
//  Copyright © 2015 DevMountain. All rights reserved.
//

import UIKit

class EntryListTableViewController: UITableViewController, UISearchResultsUpdating {

    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpSearchController()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    // MARK: - Search Controller
    func setUpSearchController() {
        let resultsViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("resultsViewController") // matches the name of the file without the extension in your project navigator (the uistoryBoard(name: x).
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.hidesNavigationBarDuringPresentation = false
        tableView.tableHeaderView = searchController.searchBar // programatically changing the tableheaderview to a search bar.
        self.definesPresentationContext = false // says that this view controlelr is resopnsible for defining the context in which our view controller is displayed.
    }
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //
        let searchTerm = searchController.searchBar.text ?? ""
        let lowerCaseSearchTerm = searchTerm.lowercaseString // changes all text to lowerCase.
        if let resultsController = searchController.searchResultsController as? EntryResultsTableViewController {
            resultsController.filteredEntries = EntryController.sharedController.entries.filter({ $0.title.lowercaseString.containsString(lowerCaseSearchTerm)})
            resultsController.tableView.reloadData()
        }
    }
    
    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.sharedController.entries.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("entryCell", forIndexPath: indexPath)
        let entry = EntryController.sharedController.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        return cell
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            let entry = EntryController.sharedController.entries[indexPath.row]
            EntryController.sharedController.removeEntry(entry)
            
            // Delete the row from the table view
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toShowEntry" {
            var selectedEntry: Entry
            let cell = sender as! UITableViewCell
            if let indexPath = (searchController.searchResultsController as! EntryResultsTableViewController).tableView.indexPathForCell(cell) {
                let filteredEntries = (searchController.searchResultsController as! EntryResultsTableViewController).filteredEntries
                selectedEntry = filteredEntries[indexPath.row]
            } else {
                let allEntries = EntryController.sharedController.entries
                let allEntriesIndexPath = tableView.indexPathForCell(cell)!
                selectedEntry = allEntries[allEntriesIndexPath.row]
            }
            if let detailViewController = segue.destinationViewController as? EntryDetailViewController {
                _ = detailViewController.view
                detailViewController.updateWithEntry(selectedEntry)
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

//
//  EntryDetailViewController.swift
//  Journal
//
//  Created by Jonathan Rogers on 3/14/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    var entry: Entry?

    @IBOutlet weak var titleTextField: UITextField!
    
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func titleClearButtonTapped(sender: AnyObject) {
        
        titleTextField.text = ""
    }
    
    @IBAction func bodyClearButtonTapped(sender: AnyObject) {
        
        bodyTextView.text = ""
        
    }
 
    @IBAction func saveButtonTapped(sender: AnyObject) {
        
        if let entry = self.entry {
            entry.title = self.titleTextField.text!
            entry.text  = self.bodyTextView.text!
        } else {
            let newEntry = Entry(title: self.titleTextField.text!, text: self.bodyTextView.text!)
            EntryController.sharedController.addEntry(newEntry)
            self.entry = newEntry
            
            ///// MESS WITH THIS
        }
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func updateWith(entry: Entry) {
        self.entry = entry
        
        /// MESS WITH THIS
        
        self.titleTextField.text = entry.title
        self.bodyTextView.text = entry.text
        
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }

}

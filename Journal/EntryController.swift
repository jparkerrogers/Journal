//
//  EntryController.swift
//  Journal
//
//  Created by Jonathan Rogers on 3/14/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//

import Foundation

class EntryController {
    
    private let entryKey = "entries"
    
    static let sharedController = EntryController()
    
    var entriesArray: [Entry]
    
    init() {
        self.entriesArray = []
        
        self.loadToPersistentStorage()
    }
    
    func addEntry(entry: Entry) {
        entriesArray.append(entry)
        
        self.saveToPersistentStorage()
        
    }
    
    func deleteEntry(entry: Entry) {
        
        if let entryIndex = entriesArray.indexOf(entry) {
            entriesArray.removeAtIndex(entryIndex)
        }
    }
    
    func loadToPersistentStorage() {
        
        let loadedEntries = NSUserDefaults.standardUserDefaults().objectForKey(entryKey) as? [Dictionary<String, AnyObject>]
        
        if let entryDictionary = loadedEntries {
            self.entriesArray = entryDictionary.map({Entry(dictionary: $0)!})
            
            // talk to a mentor about this. It makes absolutely no sense to me.
        }
    }
    
    func saveToPersistentStorage() {
        let savedEntries = self.entriesArray.map({$0.dictionaryCopy()})
        
        NSUserDefaults.standardUserDefaults().setObject(savedEntries, forKey: entryKey)
        
    }
}
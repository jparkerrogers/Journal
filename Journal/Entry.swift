//
//  Entry.swift
//  Journal
//
//  Created by Jonathan Rogers on 3/14/16.
//  Copyright © 2016 DevMountain. All rights reserved.
//


import Foundation

class Entry: Equatable {
    
    let kTitle = "title"
    let kText = "text"
    
    var title: String
    var text: String
    
    init(title: String, text:String) {
        self.title = title
        self.text = text
    }
    
    init?(dictionary: Dictionary<String, AnyObject>) {
        guard let title = dictionary[kTitle] as? String,
            let text = dictionary[kText] as? String else {
                self.title = ""
                self.text = ""
                
                return nil
        }
        
        self.title = title
        self.text = text
    }
    
    func dictionaryCopy() -> Dictionary<String, AnyObject> {
        
        let dictionary = [
            kTitle: self.title,
            kText: self.text
        ]
        return dictionary
    }
}

func == (lhs: Entry, rhs: Entry) -> Bool {
    return ObjectIdentifier(lhs) == ObjectIdentifier(rhs)
}


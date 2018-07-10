//
//  NoteExtension.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 22/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import UIKit
import CoreData

extension Note {
    
    convenience init(attributedText : NSAttributedString , createDate: Date , viewContext : NSManagedObjectContext) {
        self.init(context: viewContext)
        self.attributedText = attributedText
        self.createDate = createDate
        self.editDate = createDate
    }
    
    func setNoteTitle() {
        let attributedText = self.attributedText as! NSAttributedString
        if attributedText.string.count >= 25 {
            self.title = attributedText.attributedSubstring(from: NSRange.init(location: 0, length: 25)).string
        }
        guard let index = attributedText.string.index(of: "\n") else {
            self.title = attributedText.string
            return
        }
        self.title = String(attributedText.string[..<index])
    }
    
}
    


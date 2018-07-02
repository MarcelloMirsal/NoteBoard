//
//  Note.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 22/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import UIKit

class Note {
    
    var title: String {
        // MARK:- Making some logic here to slice the text for the title
        guard let index = attributedText.string.index(of: "\n") else {
            return attributedText.string
            
        }
        return String(attributedText.string[..<index])
    }
    var attributedText: NSAttributedString
    let createDate: String
    var editDate: String
    
    init(attributedText : NSAttributedString , createDate: String) {
        self.attributedText = attributedText
        self.createDate = createDate
        self.editDate = createDate
    }
    
}

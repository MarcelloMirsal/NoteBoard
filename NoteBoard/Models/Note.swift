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
        // TODO:- Making some logic here to slice the text for the title
        return text
    }
    var text: String
    let createDate: String
    var editDate: String
    
    init(text : String , createDate: String) {
        self.text = text
        self.createDate = createDate
        self.editDate = createDate
    }
    
}

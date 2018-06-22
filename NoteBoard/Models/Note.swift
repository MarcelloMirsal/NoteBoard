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
    var date: String
    
    init(text : String , date: String) {
       self.text = text
        self.date = date
    }
    
}

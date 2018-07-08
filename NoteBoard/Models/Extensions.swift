//
//  Extensions.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 26/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import UIKit

extension Date {
    func getCurrentDate(format : String = "MM/dd/yyyy h:mm a") -> String {
        let date = Date()
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = format
        return dateFormat.string(from: date)
    }
    
}

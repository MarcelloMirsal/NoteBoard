//
//  NoteManager.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 24/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import UIKit

protocol NoteManager {
    var notes: [Note] {get set}
    func add(note: Note)
    func update(note: Note)
    func delete(note: Note , at indexPath : IndexPath)
}

//
//  BoardViewController.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 22/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import UIKit

class BoardViewController: UIViewController , UITextViewDelegate {

    // MARK:- Outlets
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var noteTextView: UITextView!
    weak var note : Note!
    weak var noteViewControllerDelegate : NotesViewController!
    let boardToolView = UIBoardToolsView(frame: CGRect(x: 0, y: 0, width: 48, height: 48) )
    var boardMode : BoardMode = .new
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        noteTextView.becomeFirstResponder()
        noteTextView.delegate = self
        dateLabel.text = note.createDate
        noteTextView.text = note.text
        noteTextView.inputAccessoryView = boardToolView
        boardToolView.textView = noteTextView
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if boardMode == .new {
            noteViewControllerDelegate.add(note: note)
        } else {
            noteViewControllerDelegate.update(note: note)
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        note.text = textView.text
        note.editDate = Date.getCurrentDate()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.typingAttributes = boardToolView.nextTypingAttributes
    }
}


enum BoardMode {
    case new
    case edit
}







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
    var note : Note!
    weak var noteViewControllerDelegate : NotesViewController!
    let boardToolView = UIBoardToolsView(frame: CGRect(x: 0, y: 0, width: 48, height: 48) )
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteTextView.delegate = self
        dateLabel.text = note.createDate?.getCurrentDate()
        noteTextView.attributedText = note.attributedText as! NSAttributedString
        noteTextView.inputAccessoryView = boardToolView
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        boardToolView.textView = noteTextView
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        noteTextView.becomeFirstResponder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if note.attributedText == noteTextView.attributedText {
            return
        }
        note.attributedText = noteTextView.attributedText
        note.editDate = Date()
    }
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.typingAttributes = boardToolView.nextTypingAttributes
    }
}






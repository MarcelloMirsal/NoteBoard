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
    weak var noteViewControllerDelegate : NotesViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.largeTitleDisplayMode = .never
        noteTextView.becomeFirstResponder()
        noteTextView.delegate = self
        if note == nil {
            
        } else {
            
        }
        
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
    }
    

    func textViewDidChange(_ textView: UITextView) {
       
    }
    
    
}

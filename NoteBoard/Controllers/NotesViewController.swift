//
//  NotesViewController.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 22/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import UIKit

class NotesViewController: UITableViewController , NoteManager {
    func updateNotes(note: Note) {
        let indexPath = IndexPath(row: 0, section: 0)
        if note.text.isEmpty {
            notes.remove(at: indexPath.row)
            return
        }
        tableView.insertRows(at: [indexPath] , with: .automatic)
    }
    
    
    // MARK:- Properties
    var notes = [Note]()
    
    @IBAction func addNewNote() {
        //performSegue(withIdentifier: "addNote", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNote" {
            let boardController = segue.destination as! BoardViewController
            let newNote = Note(text: "", date: "Now")
            notes.insert(newNote, at: 0)
            boardController.note = newNote
            boardController.noteViewControllerDelegate = self
        } else if segue.identifier == "editNote" {
            let boardController = segue.destination as! BoardViewController
            boardController.noteViewControllerDelegate = self
        }
    }

}

// MARK:- Extension Tableview Delegate and DataSource

extension NotesViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! UINoteCell
        let note = notes[indexPath.row]
        cell.titleLabel.text = note.title
        cell.dateLabel.text = note.date
        return cell
    }

    
}


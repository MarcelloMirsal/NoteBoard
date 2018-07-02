//
//  NotesViewController.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 22/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import UIKit

class NotesViewController: UITableViewController , NoteManager {
    
    // MARK:- Properties
    var notes = [Note]()
    
    @IBAction func addNewNote() {
        //performSegue(withIdentifier: "addNote", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNote" {
            let boardController = segue.destination as! BoardViewController
            let newNote = Note(attributedText: NSAttributedString(), createDate: Date.getCurrentDate())
            notes.insert(newNote, at: 0)
            boardController.note = newNote
            boardController.noteViewControllerDelegate = self
            let indexPath = IndexPath(row: 0, section: 0)
            tableView.insertRows(at: [indexPath], with: .automatic)
        } else if segue.identifier == "editNote" {
            let cell = sender as! UINoteCell
            guard let indexPath = tableView.indexPath(for: cell) else {fatalError()}
            let boardController = segue.destination as! BoardViewController
            boardController.noteViewControllerDelegate = self
            boardController.boardMode = .edit
            boardController.note = notes[indexPath.row]
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
        cell.dateLabel.text = note.editDate
        return cell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { (delAction, indexPath) in
            weak var weakSelf = self
            weakSelf!.delete(note: weakSelf!.notes[indexPath.row] , at: indexPath)
        }
        return [deleteAction]
    }

    
}
// MARK:- implementing the NoteManager Protocol
extension NotesViewController {
    
    func update(note: Note) {
        let noteIndex = notes.index { (noteItem) -> Bool in return noteItem === note}
        if let index = noteIndex {
            let indexPath = IndexPath(row: index, section: 0)
            let cell = tableView.cellForRow(at: indexPath) as! UINoteCell
            if note.attributedText.string.isEmpty {
                notes.remove(at: index)
                tableView.deleteRows(at: [indexPath], with: .automatic)
            } else {
                if cell.titleLabel.text == note.attributedText.string {
                    return
                }
                notes.remove(at: index)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                notes.insert(note, at: 0)
                tableView.insertRows(at: [indexPath], with: .automatic)
            }
            
        } else {
            fatalError()
        }
        
        tableView.reloadData()
    }
    
    func add(note: Note) {
        let indexPath = IndexPath(row: 0, section: 0)
        if note.attributedText.string.isEmpty {
            notes.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            return
        }
        
        tableView.reloadData()
    }
    
    func delete(note: Note , at indexPath: IndexPath) {
        notes.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    
}


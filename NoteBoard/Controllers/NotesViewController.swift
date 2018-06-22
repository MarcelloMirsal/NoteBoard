//
//  NotesViewController.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 22/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import UIKit

protocol NoteManager {
    func update(note : Note)
    func reload(note: Note)
}

class NotesViewController: UITableViewController , NoteManager{
    
    // MARK:- Properties
    var notes = [Note]()
    
    @IBAction func addNewNote() {
        performSegue(withIdentifier: "addNote", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNote" {
            let boardController = segue.destination as! BoardViewController
            boardController.noteViewControllerDelegate = self
        } else if segue.identifier == "EditNote" {
            let boardController = segue.destination as! BoardViewController
            boardController.noteViewControllerDelegate = self
            let cell = sender as! UINoteCell
            guard let cellIndex = tableView.indexPath(for: cell) else {fatalError()}
            boardController.note = notes[cellIndex.row]
        }
    }
    
    // MARK:- Note Manager
    func reload(note: Note) {

    }
    
    func update(note: Note) {

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


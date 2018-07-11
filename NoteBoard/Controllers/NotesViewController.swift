//
//  NotesViewController.swift
//  NoteBoard
//
//  Created by Marcello Mirsal on 22/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import UIKit
import CoreData

class NotesViewController: UITableViewController, NSFetchedResultsControllerDelegate {
    
    
    // MARK:- Properties
    var dataManager: DataManager!
    var fetchResultsController : NSFetchedResultsController<Note>!
    
    
    // MARK:- Methods and Actions
    fileprivate func setupFetchResultsController() {
        let fetchRequest : NSFetchRequest<Note> = Note.fetchRequest()
        let sortDescriptor = NSSortDescriptor(key: "editDate", ascending: false)
        fetchRequest.sortDescriptors = [sortDescriptor]
        fetchResultsController = NSFetchedResultsController<Note>.init(fetchRequest: fetchRequest, managedObjectContext: dataManager.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        fetchResultsController.delegate = self
        do {
            try fetchResultsController.performFetch()
        } catch {
            fatalError("error fetch results")
        }
    }
    
    func removeEmptyNote(){
        guard let lastWorkingNote = fetchResultsController.sections?[0].objects?.first as? Note else {
            return
        }
        if (lastWorkingNote.attributedText as! NSAttributedString).string.isEmpty {
            dataManager.viewContext.delete(lastWorkingNote)
        } else {
            tableView.reloadRows(at: [IndexPath(row: 0, section: 0) ], with: .none)
        }
    }
    
    @IBAction func addNewNote() {
        
    }
    
    // MARK:- viewController Delegate
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFetchResultsController()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        removeEmptyNote()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNote" {
            let boardController = segue.destination as! BoardViewController
            let newNote = Note(attributedText: NSAttributedString(), createDate: Date() , viewContext:
                dataManager.viewContext)
            boardController.note = newNote
            boardController.noteViewControllerDelegate = self
            
        } else if segue.identifier == "editNote" {
            let cell = sender as! UINoteCell
            guard let indexPath = tableView.indexPath(for: cell) else {fatalError()}
            let boardController = segue.destination as! BoardViewController
            boardController.noteViewControllerDelegate = self
            boardController.note = fetchResultsController.object(at: indexPath)
        }
    }
}


// MARK:- Extension Tableview Delegate and DataSource

extension NotesViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return fetchResultsController.sections?.count ?? 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NoteCell", for: indexPath) as! UINoteCell
        let note = fetchResultsController.object(at: indexPath)
        cell.dateLabel.text = note.editDate?.getCurrentDate()
        
        guard let attributedString = note.attributedText as? NSAttributedString else {
            return cell
        }
        cell.titleLabel.attributedText = attributedString.string.count >= 50 ? attributedString.attributedSubstring(from: NSRange.init(location: 0, length: 50) ) : attributedString
        // if theres no text at all
        if attributedString.string.isEmpty {cell.titleLabel.text = "New Note"}
        return cell
    }

    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "Delete") { [weak self] (delAction, indexPath) in
            let noteToDelete = self?.fetchResultsController.object(at: indexPath)
            self?.dataManager.viewContext.delete(noteToDelete!)
        }
        return [deleteAction]
    }

}


// MARK:- implementing fetchResultController Delegate
extension NotesViewController {
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .fade)
        case .update :
            tableView.reloadRows(at: [indexPath!], with: .fade)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .fade)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        }
    }
    
}








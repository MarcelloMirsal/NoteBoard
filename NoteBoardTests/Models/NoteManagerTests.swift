//
//  NoteManagerTests.swift
//  NoteBoardTests
//
//  Created by Marcello Mirsal on 24/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import XCTest
@testable import NoteBoard

class NoteManagerTests: XCTestCase {
    
    var dataManager = DataManager(modelName: "NoteBoard")
    
    var navigationController : UINavigationController!
    var notesViewController : NotesViewController!
    var boardViewController : BoardViewController!
    var noteSample1 : Note!
    var noteSample2 : Note!
    var noteSample3 : Note!
    
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        navigationController = mainStoryboard.instantiateInitialViewController() as! UINavigationController
        notesViewController = navigationController.topViewController as! NotesViewController
        boardViewController = mainStoryboard.instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
        
        noteSample1 = Note(attributedText: NSAttributedString(string: "Hello There"), createDate: Date(), viewContext: dataManager.viewContext)
        
        noteSample2 = Note(attributedText: NSAttributedString(string: "My name is "), createDate: Date(), viewContext: dataManager.viewContext)
        noteSample3 = Note(attributedText: NSAttributedString(string: "House"), createDate: Date(), viewContext: dataManager.viewContext)
        boardViewController.note = noteSample1
        _ = navigationController.view
        _ = notesViewController.view
        _ = boardViewController.view
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK:- Test NoteManager To add a new note
    
    func testNoteManagerCreateNewNote_NoteShouldBeEqualInBoardAndNotes(){
        let storyboardSegue = UIStoryboardSegue(identifier: "addNote", source: notesViewController, destination: boardViewController)
        notesViewController.prepare(for: storyboardSegue, sender: nil)
        boardViewController.noteTextView.text = "Hello World!"
        boardViewController.textViewDidChange(boardViewController.noteTextView)
        notesViewController.navigationController?.popViewController(animated: true)
        let attributedString = notesViewController.notes[0].attributedText as! NSAttributedString
        XCTAssertEqual(attributedString.string, "Hello World!")
    }
    
    func testNoteMangerPresentingTheNewNote_NewNoteShouldBeFirstOrdered(){
        let storyboardSegue = UIStoryboardSegue(identifier: "addNote", source: notesViewController, destination: boardViewController)
        notesViewController.prepare(for: storyboardSegue, sender: nil)
        boardViewController.noteTextView.text = "Hello World!"
        boardViewController.textViewDidChange(boardViewController.noteTextView)
        navigationController.popViewController(animated: true)
        boardViewController.viewDidDisappear(true) // which has the reload method
        notesViewController.tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = notesViewController.tableView.cellForRow(at: indexPath) as! UINoteCell
        XCTAssertEqual(cell.titleLabel!.text, "Hello World!")
    }
    
    // MARK:- testing the edit mode
    
    func testNoteManagerPresentingProperNote_UIoutputShouldBeEqualToNote() {
        setupControllersForEditMode()
        XCTAssertTrue(boardViewController.boardMode == .edit)
        XCTAssertEqual(boardViewController.note.attributedText,noteSample2.attributedText)
        XCTAssertEqual(boardViewController.dateLabel.text, noteSample2.createDate?.getCurrentDate())
    }
    
    // MARK:- test edited note
    func testNoteManagerIsUpdatingValues_EditedNoteShouldBeEqualToChanges(){
        setupControllersForEditMode()
        let sampleText = "edit this note"
        boardViewController.noteTextView.text = sampleText
        boardViewController.textViewDidChange(boardViewController.noteTextView)
        notesViewController.navigationController?.popViewController(animated: true)
        boardViewController.viewDidDisappear(true)
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        let cell = notesViewController.tableView.cellForRow(at: selectedIndexPath) as! UINoteCell
        XCTAssertTrue(boardViewController.boardMode == .edit)
        XCTAssertEqual((noteSample2.attributedText as! NSAttributedString).string, sampleText)
        XCTAssertEqual(cell.titleLabel.text, sampleText)
    }
    
    func setupControllersForEditMode() {
        let storyboardSegue = UIStoryboardSegue(identifier: "editNote", source: notesViewController, destination: boardViewController)
        notesViewController.notes = [noteSample1 , noteSample2 , noteSample3]
        notesViewController.tableView.reloadData()
        let selectedIndexPath = IndexPath(row: 1, section: 0)
        let cell = notesViewController.tableView.cellForRow(at: selectedIndexPath) as! UINoteCell
        notesViewController.prepare(for: storyboardSegue, sender: cell)
        boardViewController.boardMode = .edit
    }
    
    // MARK:- test deleting note
    func testNoteManagerDeletingNote_NotesShouldBeEqualToZero() {
        notesViewController.notes.append(noteSample1)
        notesViewController.tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        notesViewController.delete(note: noteSample1 , at : indexPath)
        XCTAssertEqual(notesViewController.notes.count, 0)
    }
    
    func testNoteManagerDeletingNote_NotesTableViewCellsShouldBeEqualToZero() {
        notesViewController.notes.append(noteSample1)
        notesViewController.tableView.reloadData()
        let indexPath = IndexPath(row: 0, section: 0)
        notesViewController.delete(note: noteSample1 , at : indexPath)
        XCTAssertEqual(notesViewController.tableView.numberOfRows(inSection: 0), 0)
    }
    
    
    

    
    
    
    
}

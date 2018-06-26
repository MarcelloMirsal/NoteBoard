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
    
    var navigationController : UINavigationController!
    var notesViewController : NotesViewController!
    var boardViewController : BoardViewController!
    var sampleNote1 = Note(text: "Hello World", createDate: Date.getCurrentDate())
    var sampleNote2 = Note(text: "doing some sketching", createDate: Date.getCurrentDate())
    var sampleNote3 = Note(text: "this me ", createDate: Date.getCurrentDate())
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        navigationController = mainStoryboard.instantiateInitialViewController() as! UINavigationController
        notesViewController = navigationController.topViewController as! NotesViewController
        boardViewController = mainStoryboard.instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
        boardViewController.note = sampleNote1
        _ = navigationController.view
        _ = notesViewController.view
        _ = boardViewController.view
        
        sampleNote1 = Note(text: "Hello World", createDate: Date.getCurrentDate())
        sampleNote2 = Note(text: "doing some sketching", createDate: Date.getCurrentDate())
        sampleNote3 = Note(text: "this me ", createDate: Date.getCurrentDate())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    // MARK:- Test NoteManager To add a new note
    
    func testNoteManagerToCreateNewNote_NoteShouldBeEqualInBoardAndNotes(){
        let storyboardSegue = UIStoryboardSegue(identifier: "addNote", source: notesViewController, destination: boardViewController)
        notesViewController.prepare(for: storyboardSegue, sender: nil)
        boardViewController.noteTextView.text = "Hello World!"
        boardViewController.textViewDidChange(boardViewController.noteTextView)
        notesViewController.navigationController?.popViewController(animated: true)
        XCTAssertEqual(notesViewController.notes[0].text, "Hello World!")
    }
    
    func testNoteMangerIsPresentingTheNewNote_NewNoteShouldBeFirstOrdered(){
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
    
    func testNoteManagerIsPresentingProperNote_UIoutputShouldBeEqualToNote() {
        setupControllersForEditMode()
        XCTAssertTrue(boardViewController.boardMode == .edit)
        XCTAssertEqual(boardViewController.note.text,sampleNote2.text)
        XCTAssertEqual(boardViewController.dateLabel.text, sampleNote2.createDate)
    }
    
    // MARK:- test edited note
    func testNoteManagerIsUpdatingValues(){
        setupControllersForEditMode()
        let sampleText = "edit this note"
        boardViewController.noteTextView.text = sampleText
        boardViewController.textViewDidChange(boardViewController.noteTextView)
        notesViewController.navigationController?.popViewController(animated: true)
        boardViewController.viewDidDisappear(true)
        let selectedIndexPath = IndexPath(row: 0, section: 0)
        let cell = notesViewController.tableView.cellForRow(at: selectedIndexPath) as! UINoteCell
        XCTAssertTrue(boardViewController.boardMode == .edit)
        XCTAssertEqual(sampleNote2.text, sampleText)
        XCTAssertEqual(cell.titleLabel.text, sampleText)
    }
    
    func setupControllersForEditMode() {
        let storyboardSegue = UIStoryboardSegue(identifier: "editNote", source: notesViewController, destination: boardViewController)
        notesViewController.notes = [sampleNote1 , sampleNote2 , sampleNote3]
        notesViewController.tableView.reloadData()
        let selectedIndexPath = IndexPath(row: 1, section: 0)
        let cell = notesViewController.tableView.cellForRow(at: selectedIndexPath) as! UINoteCell
        notesViewController.prepare(for: storyboardSegue, sender: cell)
        boardViewController.boardMode = .edit
    }
    
    
    

    
    
    
    
}

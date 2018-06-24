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
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        navigationController = mainStoryboard.instantiateInitialViewController() as! UINavigationController
        notesViewController = navigationController.topViewController as! NotesViewController
        boardViewController = mainStoryboard.instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
        _ = navigationController.view
        _ = notesViewController.view
        _ = boardViewController.view
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
    
    func testNoteMangerIsPresentingTheNewNote_NwqNoteShouldBeFirstOrdered(){
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
    
    
    
    
    
}

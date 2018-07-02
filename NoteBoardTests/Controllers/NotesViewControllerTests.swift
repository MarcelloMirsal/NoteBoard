//
//  NoteBoardTests.swift
//  NoteBoardTests
//
//  Created by Marcello Mirsal on 22/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import XCTest
@testable import NoteBoard

class NotesViewControllerTests: XCTestCase {
    
    var sut : NotesViewController!
    let sampleNote = Note(attributedText: NSAttributedString(string: "Hello there , guy this is amazing") , createDate: Date.getCurrentDate())
    

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let rootNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
        
        sut = rootNavigationController.topViewController as! NotesViewController
        _ = sut.view
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK:- test NotesViewController init
    func testNotesController_ShouldBeNotNil() {
        XCTAssertNotNil(sut)
    }
    // MARK:- test NotesViewController Tableview delegate and datasource
    func testNotesControllerTableViewDelegate_ShouldBeNotNil() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is NotesViewController)
    }
    
    func testNotesControllerTableViewDataSource_ShouldBeNotNil() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is NotesViewController)
    }
    
    // MARK:- test NoteViewController notes array
    
    func testNotesControllerNotesArray_ShouldPresentRowWithSamplevalue(){
        sut.notes.append(sampleNote)
        sut.tableView.reloadData()
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UINoteCell
        XCTAssertEqual(cell.titleLabel.text, sampleNote.title)
        XCTAssertEqual(cell.dateLabel.text, sampleNote.createDate)
    }
    
    func testNotesControllerNotesArrayCount_ShouldBeEqualToNumberOfAppends(){
        sut.notes.append(sampleNote)
        sut.tableView.reloadData()
        XCTAssertEqual(sut.notes.count, 1)
    }
    
    // MARK:- test NotesViewController Tableview registered Cell
    func testNotesControllerRegisteredCell_ShouldBeNotNil(){
        sut.notes.append(sampleNote)
        sut.tableView.reloadData()
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? UINoteCell
        XCTAssertNotNil(cell)
        
    }
    
    // MARK: NotesViewController delegate pass
    func testNotesControllerPassNewNoteToAddNewNote_NoteShouldBeNotNil(){
        let boardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
        let segue = UIStoryboardSegue(identifier: "addNote", source: sut, destination: boardViewController)
       sut.prepare(for: segue, sender: nil)
        XCTAssertNotNil(boardViewController.note)
    }
    
    // MARK:- test confirmation of Note Manager Protocol
    
    func testSutIsConformingNoteManager() {
        let noteManger : NoteManager = sut as NoteManager
        XCTAssertNotNil(noteManger)
    }
    
    

}

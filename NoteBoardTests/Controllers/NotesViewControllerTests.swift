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
    let sampleNote = Note(text: "Hello there , guy this is amazing", date: "10/12/2017")
    
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
    func testSut_ShouldBeNotNil() {
        XCTAssertNotNil(sut)
    }
    // MARK:- test NotesViewController Tableview delegate and datasource
    func testSutTableViewDelegate_ShouldBeNotNil() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is NotesViewController)
    }
    
    func testSutTableViewDataSource_ShouldBeNotNil() {
        XCTAssertNotNil(sut.tableView.delegate)
        XCTAssertTrue(sut.tableView.delegate is NotesViewController)
    }
    
    func testSutNotesArray_ShouldPresentRowWithSamplevalue(){
        sut.notes.append(sampleNote)
        sut.tableView.reloadData()
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! UINoteCell
        XCTAssertEqual(cell.titleLabel.text, sampleNote.title)
        XCTAssertEqual(cell.dateLabel.text, sampleNote.date)
    }
    
    func testSutNotesArrayCount_ShouldBeEqualToNumberOfAppends(){
        sut.notes.append(sampleNote)
        sut.tableView.reloadData()
        XCTAssertEqual(sut.notes.count, 1)
    }
    
    // MARK:- test NotesViewController Tableview registered Cell
    func testSutRegisteredCell_ShouldBeNotNil(){
        sut.notes.append(sampleNote)
        sut.tableView.reloadData()
        let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? UINoteCell
        XCTAssertNotNil(cell)
        
    }
    
    // MARK:- test passing note delegate to board Controller
    func testSutForPassingDelegate_ShouldBeEquaulToSUT(){
        let board = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
        board.noteViewControllerDelegate = sut
        XCTAssertEqual(sut, board.noteViewControllerDelegate)
    }
    
    
    
    
    
}

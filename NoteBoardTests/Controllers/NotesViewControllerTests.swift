//
//  NoteBoardTests.swift
//  NoteBoardTests
//
//  Created by Marcello Mirsal on 22/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import XCTest
import CoreData
@testable import NoteBoard

class NotesViewControllerTests: XCTestCase , NSFetchedResultsControllerDelegate {
    
    var dataManager = DataManager(modelName: "NoteBoard")
    var sut : NotesViewController!
    var sampleNote : Note!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        dataManager.loadStore(completion: nil)
        sampleNote = nil
        let rootNavigationController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! UINavigationController
        sut = rootNavigationController.topViewController as! NotesViewController
        sut.dataManager = dataManager
        _ = sut.view
        _ = sut.tableView
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
    
    func testFetchResultsController_ShouldPresentRowWithSampleValue(){
        
    }
    
    func testFetchResultsControllerCount_ShouldBeEqualToNumberOfAppends(){

    }
    
    // MARK:- test NotesViewController Tableview registered Cell
    func testNotesControllerRegisteredCell_ShouldBeNotNil(){

    }
    
    // MARK: NotesViewController delegate pass
    func testNotesControllerPassNewNoteToAddNewNote_NoteShouldBeNotNil(){
        let boardViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
        let segue = UIStoryboardSegue(identifier: "addNote", source: sut, destination: boardViewController)
       sut.prepare(for: segue, sender: nil)
        XCTAssertNotNil(boardViewController.note)
    }
    
    
    // MARK:- test for data persistence
    func testFetchResultsController_ShouldBeNotNil(){
        XCTAssertNotNil(sut.fetchResultsController)
    }
    
    func testFetchResultControllerDelegate_ShouldBeEqualToSut(){
        XCTAssertTrue(sut.fetchResultsController.delegate === sut)
    }
    

}


// MARK:- Mock up for testing insert , delete and update
















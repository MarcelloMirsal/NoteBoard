//
//  BoardViewControllerTests.swift
//  NoteBoardTests
//
//  Created by Marcello Mirsal on 22/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import XCTest
@testable import NoteBoard

class BoardViewControllerTests: XCTestCase {
    
    let dataManager = DataManager(modelName: "NoteBoard")
    var sut : BoardViewController!
    var sampleNote: Note!
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
        let notesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
        
        sampleNote = Note(attributedText: NSAttributedString(string: "i am coool "), createDate: Date(), viewContext: dataManager.viewContext)
        sut.noteViewControllerDelegate = notesViewController
        sut.note = sampleNote
        _ = sut.view
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK:- test BoardViewController nils in init
    func testBoardController_ShouldBeNotNill(){
        XCTAssertNotNil(sut)
    }
    
    // MARK:- test BoardViewController Outlets
    func testBoardControllerOutlets_ShouldBeNotNil(){
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertNotNil(sut.noteTextView)
        XCTAssertNotNil(sut.boardToolView)
        XCTAssertNotNil(sut.noteTextView.inputAccessoryView) // noteTextView inputAccessoryView
    }
    
    // MARK:- test noteViewControllerDelegate delegate
    func testBoardControllerNotesViewControllerDelegate_ShouldBeNotNill(){
        XCTAssertNotNil(sut.noteViewControllerDelegate)
    }
    
    // MARK:- test BoardViewController note
    func testBoardControllerNote_ShouldBeNotNil() {
        XCTAssertNotNil(sut.note)
    }
    
    // MARK:- updating the UI from note Model
    func testBoardControllerPresentingNoteEditDate_ShouldBeEqualToNote() {
        sut.note = sampleNote
        sut.noteTextView.attributedText = sut.note.attributedText as! NSAttributedString
        sut.dateLabel.text = sut.note.createDate?.getCurrentDate()
        let attributedString = sut.note.attributedText as! NSAttributedString
        XCTAssertEqual(sut.dateLabel.text, sut.note.createDate?.getCurrentDate())
        XCTAssertEqual(attributedString.string, sut.noteTextView.attributedText.string)
    }
    
    //MARK:- TextView Delegate and inputs
    func testBoardControllerNoteTextViewDelegate_ShouldBeNotNil(){
        XCTAssertNotNil(sut.noteTextView.delegate)
    }
    
}

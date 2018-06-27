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
    
    var sut : BoardViewController!
    let sampleNote = Note(text: "Hello there", createDate: Date.getCurrentDate())
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
        let notesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
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
    }
    
    // MARK:- test noteViewControllerDelegate delegate
    func testBoardControllerNotesViewControllerDelegate_ShouldBeNotNill(){
        XCTAssertNotNil(sut.noteViewControllerDelegate)
    }
    
    // MARK:- test BoardViewController note
    func testBoardControllerNote_ShouldBeNotNil() {
        XCTAssertNotNil(sut.note)
    }
    
    // MARK:- test BoardViewController mode for new note or edit note
    func testBoardControllerMode_ShouldBeNewForEmptyNoteText(){
        if sut.note.text.isEmpty {
            XCTAssertTrue(sut.boardMode == .new) // by default
        }
    }
    
    func testBoardControllerMode_ShouldBeEditForNoteText(){
        sut.note = sampleNote
        sut.boardMode = .edit
        if sut.note.text.isEmpty == false {
            XCTAssertTrue(sut.boardMode == .edit)
        }
    }
    
    // MARK:- updating the UI from note Model
    func testBoardControllerPresentingNoteEditDate_ShouldBeEqualToNote() {
        sut.note = sampleNote
        sut.noteTextView.text = sut.note.text
        sut.dateLabel.text = sut.note.createDate
        XCTAssertEqual(sut.dateLabel.text, sut.note.createDate)
        XCTAssertEqual(sut.noteTextView.text, sut.note.text)
    }
    
    //MARK:- TextView Delegate and inputs
    func testBoardControllerNoteTextViewDelegate_ShouldBeNotNil(){
        XCTAssertNotNil(sut.noteTextView.delegate)
    }
    
    func testBoardControllerTextViewInputDidChange_NoteTextViewMustEqualToNoteText(){
        sut.note = sampleNote
        sut.noteTextView.text = "Hello World!"
        sut.noteTextView.delegate!.textViewDidChange!(sut.noteTextView)
        XCTAssertEqual(sut.noteTextView.text, sut.note.text)
    }
    
    
}

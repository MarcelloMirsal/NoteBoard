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
    let emptyNote = Note(text: "", date: "Now")
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BoardViewController") as! BoardViewController
        let notesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NotesViewController") as! NotesViewController
        sut.noteViewControllerDelegate = notesViewController
        _ = sut.view
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK:- sut and outlets Nils
    func testSut_isNotNill(){
        XCTAssertNotNil(sut)
    }
    
    func testSutNotesViewControllerDelegate_IsNotNill(){
        XCTAssertNotNil(sut.noteViewControllerDelegate)
    }
    
    func testSutOutlets_IsNotNil(){
        _ = sut.view
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertNotNil(sut.noteTextView)
    }
    
    // MARK:- configuring sut for new Note

    func testSutOutletsForNewNote_ShouldBeEmpty(){
        XCTAssertTrue(sut.noteTextView.text.isEmpty)
        XCTAssertTrue(sut.dateLabel.text!.isEmpty)
    }
    
    //MARK:- TextView Delegate and inputs
    func testSutNoteTextViewDelegate_NotNil(){
        XCTAssertNotNil(sut.noteTextView.delegate)
    }
    
    func testSutTextViewInputDidChange_TextViewMustEqualToNoteText(){
        sut.note = emptyNote
        sut.noteTextView.text = "Hello World!"
        sut.noteTextView.delegate!.textViewDidChange!(sut.noteTextView)
        XCTAssertEqual(sut.noteTextView.text, sut.note.text)
    }
    
    
}

//
//  NoteTests.swift
//  NoteBoardTests
//
//  Created by Marcello Mirsal on 22/06/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import XCTest
@testable import NoteBoard

class NoteTests: XCTestCase {
    
    var sut: Note!
    let noteText = "Hello This is my note hello guys"
    let noteCreateDate = Date.getCurrentDate()
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = Note(text: noteText, createDate: noteCreateDate)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK:- test Note init
    
    func testNoteInit_ShouldBeAlwaysNotNil() {
        XCTAssertNotNil(sut)
    }
    
    
    func testNoteCreateDateAndEditDate_ShouldBeEqual() {
        XCTAssertEqual(sut.editDate, noteCreateDate)
    }
    
    
    func testNoteInit_ShouldBeConstructedWithProperValues(){
        XCTAssertEqual(sut.text, noteText)
        XCTAssertEqual(sut.createDate, noteCreateDate)
        XCTAssertEqual(sut.editDate, noteCreateDate)
    }
    
    func testNoteTitle_ShouldBeSlicedFromNoteTextToFirstNewLine(){
        let sampleNoteText = "Hello This is my note\n hello guys"
        sut.text = sampleNoteText
        XCTAssertEqual("Hello This is my note", sut.title)
        
        let sampleNoteText2 = "The Movie \n Batman"
        sut.text = sampleNoteText2
        XCTAssertEqual("The Movie ", sut.title)
        
        let sampleNoteText3 = "Batman Dark Knight"
        sut.text = sampleNoteText3
        XCTAssertEqual("Batman Dark Knight", sut.title)
        
        
    }
    
    
}

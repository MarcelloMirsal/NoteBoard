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
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    
    func testSutInit(){
        let noteText = "Hello This is my note , hello guys"
        let noteCreateDate = Date.getCurrentDate()
        let noteEditDate = noteCreateDate
        let sut = Note(text: noteText, createDate: noteCreateDate)
        XCTAssertEqual(sut.text, noteText)
        XCTAssertEqual(sut.createDate, noteCreateDate)
        XCTAssertEqual(sut.title, noteText)
        XCTAssertEqual(sut.editDate, noteEditDate)
    }
    
}

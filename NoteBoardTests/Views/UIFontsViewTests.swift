//
//  UIFontsViewTests.swift
//  NoteBoardTests
//
//  Created by Marcello Mirsal on 02/07/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import XCTest
@testable import NoteBoard
class UIFontsViewTests: XCTestCase {
    
    var sut : UIFontsView!
    override func setUp() {
        super.setUp()
        sut = UIFontsView()
        _ = sut
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK:- test init
    func testInit_ShouldBeNotNil(){
        XCTAssertNotNil(sut)
    }
    
    // MARK:- test properties
    func testProperties_ShouldBeNotNil() {
        XCTAssertNotNil(sut.contentsView)
        XCTAssertNotNil(sut.dismissButton)
        XCTAssertNotNil(sut.boldStyleButton)
        XCTAssertNotNil(sut.italicStyleButton)
        XCTAssertNotNil(sut.normalStyleButton)
    }
    
    // MARK:- test boardToolsViewDelegate
    func testBoardToolsViewDelegate_SouldBeNotNill(){
        let boardViewController = UIBoardToolsView()
        sut.boardToolsViewDelegate = boardViewController
        XCTAssertNotNil(sut.boardToolsViewDelegate)
    }
    
    func testBoardToolsViewDelegate_isEqualToPassedDelegate(){
        let boardViewController = UIBoardToolsView()
        sut.boardToolsViewDelegate = boardViewController
        XCTAssertEqual(boardViewController, sut.boardToolsViewDelegate)
    }
    
    
    // MARK:- test dismiss button
    func testDismissButtonTarget_ShouldBeNotNilandEqualTo()  { // handleDismissKeyboardWithSender:
        let actionsString = sut.dismissButton.actions(forTarget: sut, forControlEvent: .touchUpInside)
        XCTAssertNotNil(actionsString)
        XCTAssertEqual(actionsString!.first!, "handleDismissKeyboardWithSender:")
    }
    

    
    
}

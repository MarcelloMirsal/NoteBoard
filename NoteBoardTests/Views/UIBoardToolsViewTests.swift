//
//  UIBoardToolsViewTests.swift
//  NoteBoardTests
//
//  Created by Marcello Mirsal on 01/07/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import XCTest
@testable import NoteBoard

class UIBoardToolsViewTests: XCTestCase {
    
    var sut : UIBoardToolsView!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = UIBoardToolsView()
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK:- test init
    func testInit_ShouldBeNotNil(){
        XCTAssertNotNil(sut)
    }
    
    // MARK:- test properties sub-view
    
    func testProperties_ShouldBeNotNil(){
        XCTAssertNotNil(sut.fontButton)
        XCTAssertNotNil(sut.nextTypingAttributes)
        XCTAssertNotNil(sut.fontsView)
    }
    
    
    // MARK:- tests fontButton
    func testFontButtonSelectorForEventTouchUpInside_ShouldBeNotNil(){
        let actionsString = sut.fontButton.actions(forTarget: sut, forControlEvent: .touchUpInside)
        XCTAssertEqual(actionsString?.count, 1)
        XCTAssertNotNil(actionsString?.first)
        XCTAssertEqual(actionsString?.first, "handleFontButtonWithSender:")
    }
    
    
    
    
}

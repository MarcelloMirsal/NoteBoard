//
//  DataManagerTests.swift
//  NoteBoardTests
//
//  Created by Marcello Mirsal on 08/07/2018.
//  Copyright © 2018 Marcello Mirsal. All rights reserved.
//

import XCTest
@testable import NoteBoard

class DataManagerTests: XCTestCase {
    
    var sut : DataManager!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = DataManager(modelName : "NoteBoard")
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    // MARK:- test Init
    func testInit_ShouldBeNotNil() {
        XCTAssertNotNil(sut)
    }
    
    // MARK:- test context and persistence container
    func testViewContext_ShouldBeEqualToPersistenceContainerContext(){
        XCTAssertEqual(sut.persistentContainer.viewContext, sut.viewContext)
    }

    
}

//
//  ListVMTest.swift
//  MovieTests
//
//  Created by Edo Oktarifa on 24/04/21.
//

import XCTest
@testable import Movie

class ListVMTest: XCTestCase {
    func testNetwork(){
        let listVM = ListVM()
        
        listVM.request { (movie) in
            XCTAssertNotNil(movie, "Expected non-nil string")
        } error: { (error) in
            XCTFail("Error: \(error.localizedDescription)")
        }
        
//        waitForExpectations(timeout: 5.0, handler: nil)
    }
}

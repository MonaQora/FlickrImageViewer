//
//  FlickrPhotosService.swift
//  FlickrImageViewerTests
//
//  Created by Mona Qora on 11/3/19.
//  Copyright © 2019 Mona Qora. All rights reserved.
//

import XCTest

class FlickrPhotosServiceTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNormalRequest() {
        let searchKey = "Pizza"
        fetchFlickrSerachResults(searchKey: searchKey, taskCallback: {sucess, error, response in
            if sucess {
                XCTAssertNil(error)
                XCTAssertNotNil(response)
            }
            else {
                XCTAssertNil(response)
                XCTAssertNotNil(error)
                XCTFail("Error: \(error!.localizedDescription)")
            }
        })
    }

    func testEmptySearchKeyRequest() {
        fetchFlickrSerachResults(searchKey: "", taskCallback: {sucess, error, response in
                XCTAssertNil(response)
                XCTAssertNotNil(error)
                XCTFail("Error: \(error!.localizedDescription)")
                XCTAssertEqual(sucess, false)
        })
    }
    
    func testWrongSearchKeyRequest() {
        let searchKey = "I'mRandomWordToTestSearch"
        fetchFlickrSerachResults(searchKey: searchKey, taskCallback: {sucess, error, response in
                XCTAssertNil(response)
                XCTAssertNotNil(error)
                XCTFail("Error: \(error!.localizedDescription)")
                XCTAssertEqual(sucess, false)
        })
    }
}


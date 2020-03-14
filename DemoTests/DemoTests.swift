//
//  DemoTests.swift
//  DemoTests
//
//  Created by Masahiro Watanabe on 2020/03/14.
//  Copyright © 2020 Masahiro Watanabe. All rights reserved.
//

@testable import Demo
import SwiftyMocky
import XCTest

class DemoTests: XCTestCase {
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testFindUserUseCase() {
        let id = Int.random(in: 0 ..< 100)

        let mock = UserRepositoryMock()
        mock.given(.find(by: .value(id), willReturn: User(id: id)))

        let sut = FindUserUserCase(userRepository: mock)
        if let user = sut.find(by: id), user.id == id {
            XCTAssert(true)
        } else {
            XCTFail()
        }
    }
}

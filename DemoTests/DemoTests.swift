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
        let id = Int.random()
        let name = String.random()

        let mock = UserRepositoryMock()
        // Stub
        mock.given(.find(by: .value(id), willReturn: User(id: id, name: name)))

        let sut = FindUserUseCaseImpl(userRepository: mock)
        if let user = sut.execute(id), user.id == id {
            XCTAssert(true)
        } else {
            XCTFail()
        }

        // Verify mock
        mock.verify(.find(by: .value(id)), count: 1)
    }

    func testUpdateUserUseCase() {
        let id = Int.random()
        let name = String.random()

        let mock = UserRepositoryMock()

        let sut = UpdateUserUseCaseImpl(userRepository: mock)
        sut.execute(id, name: name)
        mock.verify(.update(.value(id), name: .value(name)), count: 1)
    }

    func testProfileViewModel() {
        let id = Int.random()
        let name = String.random()
        let taro = "Taro"

        let findUserMock = FindUserUseCaseMock()
        findUserMock.given(.execute(.value(id), willReturn: User(id: id, name: name)))

        let updateUserMock = UpdateUserUseCaseMock()

        let sut = ProfileViewModelImpl(id: id, findUserUseCase: findUserMock, updateUserUseCase: updateUserMock)
        let user = sut.findMyself()
        assert(user.id == id && user.name == name)
        findUserMock.verify(.execute(.value(id)), count: 1)

        sut.updateNameToTaro()
        updateUserMock.verify(.execute(.value(id), name: .value(taro)), count: 1)
    }
}

extension Int {
    static func random(_ min: Int = 0, max: Int = 100) -> Int {
        return Int.random(in: min ... max)
    }
}

extension String {
    static func random() -> String {
        return UUID().uuidString
    }
}

//
//  FindUserUseCase.swift
//  Demo
//
//  Created by Masahiro Watanabe on 2020/03/14.
//  Copyright © 2020 Masahiro Watanabe. All rights reserved.
//

import Foundation
import SwiftyMocky

protocol AutoMockable {}

struct User {
    let id: Int
    let name: String
}

protocol UserRepository: AutoMockable {
    func update(_ id: Int, name: String)
    func find(by id: Int) -> User?
}

protocol FindUserUseCase: AutoMockable {
    func execute(_ id: Int) -> User?
}

struct FindUserUseCaseImpl {
    let userRepository: UserRepository
    func execute(_ id: Int) -> User? {
        return userRepository.find(by: id)
    }
}

protocol UpdateUserUseCase: AutoMockable {
    func execute(_ id: Int, name: String)
}

struct UpdateUserUseCaseImpl {
    let userRepository: UserRepository
    func execute(_ id: Int, name: String) {
        userRepository.update(id, name: name)
    }
}

protocol ProfileViewModel: AutoMockable {
    func updateNameToTaro()
    func findMyself() -> User
}

struct ProfileViewModelImpl: ProfileViewModel {
    let id: Int
    let findUserUseCase: FindUserUseCase
    let updateUserUseCase: UpdateUserUseCase

    func updateNameToTaro() {
        updateUserUseCase.execute(id, name: "Taro")
    }

    func findMyself() -> User {
        guard let myself = findUserUseCase.execute(id) else {
            assertionFailure()
            return User(id: id, name: "")
        }
        return myself
    }
}

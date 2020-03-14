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
}

protocol UserRepository: AutoMockable {
    func find(by id: Int) -> User?
}

struct FindUserUserCase {
    let userRepository: UserRepository
    func find(by id: Int) -> User? {
        return userRepository.find(by: id)
    }
}

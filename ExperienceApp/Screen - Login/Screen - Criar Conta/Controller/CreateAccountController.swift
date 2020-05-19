//
//  CreateAccountController.swift
//  ExperienceApp
//
//  Created by Zewu Chen on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation

protocol CreateAccountControllerDelegate: AnyObject {
    func authResponser()
}

final class CreateAccountController {
    weak public var delegate: CreateAccountControllerDelegate?

    public init () { }

    public func createAccount(user: AuthModel) {
        Cloud.shared.createUser(data: user)
        UserDefaults.standard.set(user.name, forKey: "name")
        UserDefaults.standard.set(user.email, forKey: "email")
        UserDefaults.standard.set(Cloud.shared.encryptPassword(password: user.password), forKey: "password")
        UserDefaults.standard.set(user.description, forKey: "description")
        UserDefaults.standard.set(true, forKey: "logged")
    }
}

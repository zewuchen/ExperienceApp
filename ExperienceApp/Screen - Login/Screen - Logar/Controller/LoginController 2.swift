//
//  LoginController.swift
//  ExperienceApp
//
//  Created by Zewu Chen on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation

protocol LoginControllerDelegate: AnyObject {
    func authResponser()
}

final class LoginController {
    weak public var delegate: LoginControllerDelegate?

    public init () { }

    public func login(user: AuthModel) {
        Cloud.shared.authUser(data: user) { (user, error) in
            if let user = user {
                UserDefaults.standard.set(user["name"], forKey: "name")
                UserDefaults.standard.set(user["email"], forKey: "email")
                UserDefaults.standard.set(user["password"], forKey: "password")
                UserDefaults.standard.set(user["description"], forKey: "description")
                UserDefaults.standard.set(true, forKey: "logged")
            } else {
                UserDefaults.standard.set(false, forKey: "logged")
            }
        }
    }
}

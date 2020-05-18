//
//  LoginController.swift
//  ExperienceApp
//
//  Created by Zewu Chen on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//
protocol LoginControllerDelegate: AnyObject {
    func authResponser()
}

final class LoginController {
    weak public var delegate: LoginControllerDelegate?

    public init () { }

    public func createAccount() {
        // TODO: Implementar o login aqui
    }
}

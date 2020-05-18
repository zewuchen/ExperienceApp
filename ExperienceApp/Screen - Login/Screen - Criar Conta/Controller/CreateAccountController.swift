//
//  CreateAccountController.swift
//  ExperienceApp
//
//  Created by Zewu Chen on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

protocol CreateAccountControllerDelegate: AnyObject {
    func authResponser()
}

final class CreateAccountController {
    weak public var delegate: CreateAccountControllerDelegate?

    public init () { }

    public func createAccount() {
        // TODO: Implementar o login aqui
    }
}

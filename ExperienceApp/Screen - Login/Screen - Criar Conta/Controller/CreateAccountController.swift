//
//  CreateAccountController.swift
//  ExperienceApp
//
//  Created by Zewu Chen on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import UIKit

protocol CreateAccountControllerDelegate: AnyObject {
    func authResponser()
    func setImageProfile()
}

final class CreateAccountController {
    weak public var delegate: CreateAccountControllerDelegate?

    public init () { }

    /**
    *Salva a foto do brinquedo pelo FileHelper e gera um UUID para o nome da imagem*
    - Parameters:
        - imagem: UIImage que contém a imagem a ser salva
    - Returns: String nome da foto do brinquedo salvo
    */
    func saveFoto(imagem: UIImage) -> String {
        let fileName = UUID().uuidString
        FileHelper.saveImage(image: imagem, nameWithoutExtension: fileName)
        return fileName
    }

    /**
    *Deleta a foto do brinquedo pelo FileHelper*
    - Parameters:
        - fileURL: caminho da imagem salva
    - Returns: Nenhum
    */
    func deleteFoto(fileURL: String?) {
        guard let fileURL = fileURL else { return }
        FileHelper.deleteImage(filePathWithoutExtension: fileURL)
    }

    public func createAccount(user: AuthModel) {
        Cloud.shared.createUser(data: user)
        UserDefaults.standard.set(user.name, forKey: "name")
        UserDefaults.standard.set(user.email, forKey: "email")
        UserDefaults.standard.set(Cloud.shared.encryptPassword(password: user.password), forKey: "password")
        UserDefaults.standard.set(user.description, forKey: "description")
        UserDefaults.standard.set(user.image, forKey: "image")
        UserDefaults.standard.set(true, forKey: "logged")
    }

    public func setImage() {
        delegate?.setImageProfile()
    }
}

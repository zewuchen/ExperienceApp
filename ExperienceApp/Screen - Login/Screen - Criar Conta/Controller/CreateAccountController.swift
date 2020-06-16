//
//  CreateAccountController.swift
//  ExperienceApp
//
//  Created by Zewu Chen on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

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
        Cloud.shared.createUser(data: user) { (newUser, erro) in
            if let newUser = newUser {
                UserDefaults.standard.set(newUser["name"], forKey: "name")
                UserDefaults.standard.set(newUser["email"], forKey: "email")
                UserDefaults.standard.set(newUser["password"], forKey: "password")
                UserDefaults.standard.set(newUser["description"], forKey: "description")
                UserDefaults.standard.set(true, forKey: "logged")
                UserDefaults.standard.set([], forKey: "marcadas")
                UserDefaults.standard.set(newUser.recordID.recordName, forKey: "userID")
                if let image = newUser["image"] {
                    guard let file: CKAsset? = image as? CKAsset else { return }
                    if let file = file {
                        if let dado = NSData(contentsOf: file.fileURL!) {
                            guard let tempImage = UIImage(data: dado as Data) else { return }
                            let fileName = UUID().uuidString
                            FileHelper.saveImage(image: tempImage, nameWithoutExtension: fileName)
                            UserDefaults.standard.set(fileName, forKey: "image")
                        }
                    }
                }
                if let experiences = newUser["experiences"] {
                    let experiencias = newUser["experiences"] as? [CKRecord.Reference]

                    var experiencesRecords: [String] = []

                    if let experiencias = experiencias {
                        for experiencia in experiencias {
                            let recordName = experiencia.recordID.recordName
                            experiencesRecords.append(recordName)
                        }
                    }

                    UserDefaults.standard.set([experiencesRecords], forKey: "marcadas")
                }
                if let admin = newUser["access"] {
                    let privilege = admin as? Int

                    if let privilege = privilege {
                        if privilege == 0 {
                            UserDefaults.standard.set(false, forKey: "admin")
                        } else if (privilege == 1) {
                            UserDefaults.standard.set(true, forKey: "admin")
                        }
                    }
                }
            } else {
                UserDefaults.standard.set(false, forKey: "logged")
            }
        }
    }

    public func setImage() {
        delegate?.setImageProfile()
    }
}

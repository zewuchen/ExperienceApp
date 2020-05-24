//
//  LoginController.swift
//  ExperienceApp
//
//  Created by Zewu Chen on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

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
                UserDefaults.standard.set([], forKey: "marcadas")
                if let image = user["image"] {
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
                if let experiences = user["experiences"] {
                    let experiencias = user["experiences"] as? [CKRecord.Reference]

                    var experiencesRecords: [String] = []

                    if let experiencias = experiencias {
                        for experiencia in experiencias {
                            let recordName = experiencia.recordID.recordName
                            experiencesRecords.append(recordName)
                        }
                    }

                    UserDefaults.standard.set(experiencesRecords, forKey: "marcadas")
                }
            } else {
                UserDefaults.standard.set(false, forKey: "logged")
            }
        }
    }
}

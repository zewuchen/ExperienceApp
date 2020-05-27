//
//  PerfilController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

protocol PerfilControllerDelegate: AnyObject {
    func reloadData(data: [ModelExperiencePerfil])
    func reloadProfileData(data: AuthModel)
}

final class PerfilController {
    private var data: [ModelExperiencePerfil] = []
    weak public var delegate: PerfilControllerDelegate?
    
    public init() {
//    self.data.append(ModelExperiencePerfil(titulo: "Panda", imagem: UIImage(named: "Fire_Demon_Ramen")!,descricao: "", data: "15/08/2020", link: "www.pandas.org"))
//        
//    self.data.append(ModelExperiencePerfil(titulo: "Lamen Com Demonios", imagem: UIImage(named: "Fire_Demon_Ramen")!, descricao: "", data: "13/09/2020", link: "demonio-do-fogo.com.br"))
    }
    
    public func reload() {
        delegate?.reloadData(data: data)
    }

    public func setUpProfileData() {
        guard let name = UserDefaults.standard.string(forKey: "name") else { return }
        guard let description = UserDefaults.standard.string(forKey: "description") else { return }
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }
        guard let password = UserDefaults.standard.string(forKey: "password") else { return }

        var user = AuthModel(name: name, description: description, email: email, password: password, image: "")

        if let image = UserDefaults.standard.string(forKey: "image") {
            user = AuthModel(name: name, description: description, email: email, password: password, image: image)
        }
        self.data = []
        getExperiences()

        delegate?.reloadProfileData(data: user)
    }

    private func getExperiences() {
        Cloud.shared.getMyExperiences { (records, erros) in
            for record in records {
                guard let name = record?["title"] else { return }
                guard let description = record?["description"] else { return }
                guard let recursos = record?["whatToTake"] else { return }
                guard let data = record?["date"] else { return }
                guard let dataExperiencia = data as? Date else { return }
                let formatarData = DateFormatter()
                formatarData.dateFormat = "dd/MM/yyyy"

                if let image = record?["image"] {
                    guard let file: CKAsset? = image as? CKAsset else { return }
                    if let file = file {
                        if let dado = NSData(contentsOf: file.fileURL!) {
                            let model = ModelExperiencePerfil(titulo: name.description, imagem: UIImage(data: dado as? Data ?? Data()) ?? UIImage(), descricao: description.description, data: formatarData.string(from: dataExperiencia), link: recursos.description)
                            self.data.append(model)
                        }
                    }
                }
            }
            self.delegate?.reloadData(data: self.data)
        }

        Cloud.shared.getExperienceCreatedByUser { (records, erros) in
            for record in records {
                guard let name = record?["title"] else { return }
                guard let description = record?["description"] else { return }
                guard let recursos = record?["whatToTake"] else { return }
                guard let data = record?["date"] else { return }
                guard let dataExperiencia = data as? Date else { return }
                let formatarData = DateFormatter()
                formatarData.dateFormat = "dd/MM/yyyy"

                if let image = record?["image"] {
                    guard let file: CKAsset? = image as? CKAsset else { return }
                    if let file = file {
                        if let dado = NSData(contentsOf: file.fileURL!) {
                            let model = ModelExperiencePerfil(titulo: name.description, imagem: UIImage(data: dado as? Data ?? Data()) ?? UIImage(), descricao: description.description, data: formatarData.string(from: dataExperiencia), link: recursos.description)
                            self.data.append(model)
                        }
                    }
                }
            }
            self.delegate?.reloadData(data: self.data)
        }
    }
}

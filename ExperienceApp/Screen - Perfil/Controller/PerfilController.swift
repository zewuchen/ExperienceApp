//
//  PerfilController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import UIKit

protocol PerfilControllerDelegate: AnyObject {
    func reloadData(data: [ModelExperiencePerfil])
    func reloadProfileData(data: AuthModel)
}

final class PerfilController {
    private var data: [ModelExperiencePerfil] = []
    weak public var delegate: PerfilControllerDelegate?
    
    public init() {
    self.data.append(ModelExperiencePerfil(titulo: "Panda", imagem: UIImage(named: "Fire_Demon_Ramen")!,descricao: "", data: "15/08/2020", link: "www.pandas.org"))
        
    self.data.append(ModelExperiencePerfil(titulo: "Lamen Com Demonios", imagem: UIImage(named: "Fire_Demon_Ramen")!, descricao: "", data: "13/09/2020", link: "demonio-do-fogo.com.br"))
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
        
        Cloud.shared.getMyExperiences { (<#[CKRecord?]#>, <#Error?#>) in
            <#code#>
        }

        delegate?.reloadProfileData(data: user)
    }
}

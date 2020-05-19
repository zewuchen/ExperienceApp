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
}

final class PerfilController {
    private var data: [ModelExperiencePerfil] = []
    weak public var delegate: PerfilControllerDelegate?
    
    public init() {
    self.data.append(ModelExperiencePerfil(titulo: "Panda", imagem: UIImage(named: "Fire_Demon_Ramen")!,descricao: "pandas fofos sao a salvacao! Vamos adora-los", data: "15/08/2020", link: "www.pandas.org"))
        
    self.data.append(ModelExperiencePerfil(titulo: "Lamen Com Demonios", imagem: UIImage(named: "Fire_Demon_Ramen")!, descricao: "Coma lamen com um demonio do fogo!", data: "13/09/2020", link: "demonio-do-fogo.com.br"))
    }
    
    public func reload() {
        delegate?.reloadData(data: data)
    }
}

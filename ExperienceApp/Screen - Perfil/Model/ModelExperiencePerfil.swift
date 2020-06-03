//
//  ModelPerfil.swift
//  ExperienceApp
//
//  Created by Nathalia Melare on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import UIKit

struct ModelExperiencePerfil {
    var titulo = String()
    var imagem = UIImage()
    var descricao = String()
    var data = String()
    var link = String()
    
    public init(titulo: String, imagem: UIImage, descricao: String, data: String, link: String) {
        self.titulo = titulo
        self.imagem = imagem
        self.descricao = descricao
        self.data = data
        self.link = link
    }
}

struct ModelPerfil {
    var imagem = UIImage()
    var biografia = UITextView()
    var nome = String()
    
    public init(imagem: UIImage, nome: String, biografia: UITextView) {
        self.imagem = imagem
        self.biografia = biografia
        self.nome = nome
    }
}

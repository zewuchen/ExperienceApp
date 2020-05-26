//
//  TelaAdmModel.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 26/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import UIKit

struct TelaAdmModel {
    var tituloExp: String
    var imgExp = UIImage()
    var descricaoExp: String
    
    public init(tituloExp: String, imgExp: UIImage, descricaoExp: String) {
        self.tituloExp = tituloExp
        self.imgExp = imgExp
        self.descricaoExp = descricaoExp
    }
}

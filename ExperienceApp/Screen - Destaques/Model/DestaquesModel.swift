//
//  DestaqueModel.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 20/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation

struct DestaquesModel {
    var infoGeralExp: String
    var nomeExp: String
    var descricaoExp: String
    
    public init(infoGeralExp: String, nomeExp: String, descricaoExp: String) {
        self.infoGeralExp = infoGeralExp
        self.nomeExp = nomeExp
        self.descricaoExp = descricaoExp
}
}

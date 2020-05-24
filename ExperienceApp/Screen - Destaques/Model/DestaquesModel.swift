//
//  DestaqueModel.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 20/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation

struct DestaquesModel {
    var nomeDestaque: String
    var descricaoDestaque: String
    var imgDestaque: String
    
    public init(nomeDestaque: String, descricaoDestaque: String, imgDestaque: String) {
        self.nomeDestaque = nomeDestaque
        self.descricaoDestaque = descricaoDestaque
        self.imgDestaque = imgDestaque
    }
}

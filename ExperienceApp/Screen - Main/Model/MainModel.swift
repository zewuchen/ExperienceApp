//
//  MainModel.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation

struct MainModel {
    var nomeDestaque: String?
    var nomeExp: String
    var descricaoExp: String
    var notaExp: Double
    var precoExp: String
    let recordName: String
    let image: Data?
    
    public init(nomeDestaque: String, nomeExp: String, descricaoExp: String, notaExp: Double, precoExp: String, recordName: String, image: Data) {
        self.nomeDestaque = nomeDestaque
        self.nomeExp = nomeExp
        self.descricaoExp = descricaoExp
        self.notaExp = notaExp
        self.precoExp = precoExp
        self.recordName = recordName
        self.image = image
    }
}


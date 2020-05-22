//
//  ExperienciasInfoController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import UIKit

protocol ExperienciasInfoControllerDelegate: AnyObject {
    func reloadData(data: ModelExperienciasInfo)
}

final class ExperienciasInfoController {
    public var dataToConvert: MainModel
    public var data: ModelExperienciasInfo
    
    weak public var delegate: ExperienciasInfoControllerDelegate?
    
    public init() {
        self.data = ModelExperienciasInfo(infoImage: UIImage(named: "Fire_Demon_Ramen")!, titleExp: "Pandas fofos comendo bambu",durationTime: 3, howManyPeople: 5, tags: ["lala"],
        descriptionExp: "Venha conhecer os pandas mais fofos que voce vera na sua vida! Eles comem bambu e sao felizes.",
        hostImage: UIImage(named: "Fire_Demon_Ramen")!, hostName: "Merida Valente", hostDescription: "Eu sou Merida, princesa de um reino distante e gosto de ursos!",
        howParticipate: "zoom é o caminho", whatYouNeedDescription: "Amor no coracao", recordName: "")
        self.dataToConvert = MainModel(nomeDestaque: "", nomeExp: "", descricaoExp: "", notaExp: 0, precoExp: "", recordName: "", image: Data(), recursos: "", comoParticipar: "", tamanho: 0)
    }
    
    public func reload() {
        guard let image = UIImage(data: dataToConvert.image ?? Data()) else { return }
        guard let tamanho = dataToConvert.tamanho else { return }
        guard let participar = dataToConvert.comoParticipar else { return }
        guard let recursos = dataToConvert.recursos else { return }
        let newData = ModelExperienciasInfo(infoImage: image, titleExp: dataToConvert.nomeExp, durationTime: 0, howManyPeople: tamanho, tags: [], descriptionExp: dataToConvert.descricaoExp, hostImage: image, hostName: "Teste"
            , hostDescription: "Teste", howParticipate: participar, whatYouNeedDescription: recursos, recordName: dataToConvert.recordName)
        self.data = newData
        delegate?.reloadData(data: data)
    }
}

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
    private var data = ModelExperienciasInfo(infoImage: UIImage(named: "Fire_Demon_Ramen")!, titleExp: "Pandas fofos comendo bambu",durationTime: 3, howManyPeople: 5, tags: [""],
                                        descriptionExp: "Venha conhecer os pandas mais fofos que voce vera na sua vida! Eles comem bambu e sao felizes.",
                                        hostImage: UIImage(named: "Fire_Demon_Ramen")!, hostName: "Merida Valente", hostDescription: "Eu sou Merida, princesa de um reino distante e gosto de ursos!",
                                        howParticipate: "zoom é o caminho", whatYouNeedDescription: "Amor no coracao")
    
    weak public var delegate: ExperienciasInfoControllerDelegate?
    
    public init() {

    }
    
    public func reload() {
        delegate?.reloadData(data: data)
    }
}

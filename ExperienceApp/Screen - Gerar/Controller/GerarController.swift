//
//  GerarController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

protocol GerarControllerDelegate: AnyObject {
    func reload()
}

final class GerarController {
    weak public var delegate: GerarControllerDelegate?

    public init() { }

    public func createExperience(data: ExperienceModel) {
        Cloud.shared.createExperience(data: data)
    }
}

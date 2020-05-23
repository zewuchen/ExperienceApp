//
//  GerarController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

protocol GerarControllerDelegate: AnyObject {
    func reload()
    func setImageProfile()
}

final class GerarController {
    weak public var delegate: GerarControllerDelegate?

    public init() { }

    public func createExperience(data: ExperienceModel) {
        Cloud.shared.createExperience(data: data)
    }

    public func setImage() {
        delegate?.setImageProfile()
    }

    /**
    *Salva a foto do brinquedo pelo FileHelper e gera um UUID para o nome da imagem*
    - Parameters:
        - imagem: UIImage que contém a imagem a ser salva
    - Returns: String nome da foto do brinquedo salvo
    */
    func saveFoto(imagem: UIImage) -> String {
        let fileName = UUID().uuidString
        FileHelper.saveImage(image: imagem, nameWithoutExtension: fileName)
        return fileName
    }

    /**
    *Deleta a foto do brinquedo pelo FileHelper*
    - Parameters:
        - fileURL: caminho da imagem salva
    - Returns: Nenhum
    */
    func deleteFoto(fileURL: String?) {
        guard let fileURL = fileURL else { return }
        FileHelper.deleteImage(filePathWithoutExtension: fileURL)
    }
}

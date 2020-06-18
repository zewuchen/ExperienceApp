//
//  File.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

protocol DestaquesControllerDelegate: AnyObject {
    func reloadData(data: [DestaquesModel])
    func reloadExp(dataExpDestaques: [ExperienciaDestaquesModel])
}

final class DestaquesController {
    private var dataDestaques: [ExperienciaDestaquesModel] = []
    weak public var delegate: DestaquesControllerDelegate?
    
    // OBS.: Essas infos peguei da classe da Main!
     public init() { }

    public func reload(data: [String]) {
        self.dataDestaques = []
        Cloud.shared.getExperiencesInHighlight(highlights: data) { (records, error) in
            for record in records {
                guard let name = record?["title"] else { return }
                guard let description = record?["description"] else { return }

                if let image = record?["image"] {
                    guard let file: CKAsset? = image as? CKAsset else { return }
                        if let file = file {
                            if let dado = NSData(contentsOf: file.fileURL!) {
                                let model = ExperienciaDestaquesModel(tituloExp: name.description,
                                                                      imagemExp: UIImage(data: dado as? Data ?? Data()) ?? UIImage(),
                                                                      descricaoExp: description.description, recordName: record?.recordID.recordName ?? "")
                            self.dataDestaques.append(model)
                        }
                    }
                }
            }
            self.delegate?.reloadExp(dataExpDestaques: self.dataDestaques)
        }
    }
}

//
//  MainController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

protocol MainControllerDelegate: AnyObject {
    func reloadData(data: [MainModel])
}

final class MainController {
    private var data: [MainModel] = []
    weak public var delegate: MainControllerDelegate?
    
    public init() {
        
        let _ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(getDataCloud), userInfo: nil, repeats: true)
    }

    @objc func getDataCloud() {
        reload()
        print("buscou os dados")
    }
    
    public func reload() {
//        self.data = []
//        Cloud.shared.getExperience(data: nil) { (records, error) in
//
//            for record in records {
//                guard let name = record?["title"] else { return }
//                guard let description = record?["description"] else { return }
//                guard let comoParticipar = record?["howToParticipate"] else { return }
//                guard let tamanho = record?["lengthGroup"] else { return }
//                guard let recursos = record?["whatToTake"] else { return }
//                guard let recordName = record?.recordID.recordName else { return }
//                guard let responsible = record?["responsible"] else { return }
//                guard let pessoa = responsible as? CKRecord.Reference else { return }
//                guard let data = record?["date"] else { return }
//                guard let dataExperiencia = data as? Date else { return }
//                let formatarData = DateFormatter()
//                formatarData.dateFormat = "dd/MM/yyyy"
//                let vagas = record?["availableVacancies"] as? Int
//                var available: Bool = false
//                if let numVagas = vagas, numVagas >= 1 {
//                    available = true
//                }
//
//                if let image = record?["image"] {
//                    guard let file: CKAsset? = image as? CKAsset else { return }
//                    if let file = file {
//                        if let dado = NSData(contentsOf: file.fileURL!) {
////                            guard let tempImage = UIImage(data: dado as Data) else { return }
//                            self.data.append(MainModel(nomeDestaque: "", nomeExp: name.description, descricaoExp: description.description, notaExp: 10.0, precoExp: description.description, recordName: record?.recordID.recordName ?? ""
//                                , image: dado as Data, recursos: recursos.description, comoParticipar: comoParticipar.description, tamanho: Int(tamanho.description),
//                                  responsible: pessoa.recordID.recordName, data: formatarData.string(from: dataExperiencia), available: available))
//                        }
//                    }
//                } else {
//                    self.data.append(MainModel(nomeDestaque: "", nomeExp: name.description, descricaoExp: description.description, notaExp: 10.0, precoExp: "Gratuito", recordName: record?.recordID.recordName ?? "", image: Data()
//                        , recursos: recursos.description, comoParticipar: comoParticipar.description, tamanho: Int(tamanho.description), responsible: pessoa.recordID.recordName, data: ""))
//                }
//            }
//
//            self.delegate?.reloadData(data: self.data)
//        }
    }
}

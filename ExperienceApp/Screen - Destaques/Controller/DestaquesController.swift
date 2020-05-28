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
    private var data: [DestaquesModel] = []
    private var dataDestaques: [ExperienciaDestaquesModel] = []
    weak public var delegate: DestaquesControllerDelegate?
    
    // OBS.: Essas infos peguei da classe da Main!
     public init() {
            let _ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(getDataCloud), userInfo: nil, repeats: true)
        }

        @objc func getDataCloud() {
            reload()
            print("Os dados foram encontrados")
        }
        
        public func reload() {
            self.data = []
            self.dataDestaques = []
//            Cloud.shared.getExperience(data: nil) { (records, error) in
//
//                for record in records {
//                    guard (record?["title"]) != nil else { return }
//                    guard (record?["description"]) != nil else { return }
//                    guard let name = record?["title"] else { return }
//                    guard let description = record?["description"] else { return }
//                    guard let recursos = record?["whatToTake"] else { return }
//                    guard let data = record?["date"] else { return }
//                    guard let dataExperiencia = data as? Date else { return }
//                    let formatarData = DateFormatter()
//                    formatarData.dateFormat = "dd/MM/yyyy"
//                    
//                    if let image = record?["image"] {
//                        guard let file: CKAsset? = image as? CKAsset else { return }
//                            if let file = file {
//                                if let dado = NSData(contentsOf: file.fileURL!) {
//                                    let model = ExperienciaDestaquesModel(tituloExp: name.description,
//                                                                          imagemExp: UIImage(data: dado as? Data ?? Data()) ?? UIImage(),
//                                                                                             descricaoExp: description.description)
//                                    self.dataDestaques.append(model)
//                                }
//                            }
//                    }
//                    
//                    //Obs.: Aumentar núm. de caracteres
//                    self.data.append(DestaquesModel(nomeDestaque: "Ta na Disney?",
//                                                    descricaoDestaque: "Você também é um amante de desenhos? Bora ver essas experiências relacionadas com a Disney então!",
//                                                    imgDestaque: "disney"))
//                                     
//                                    
//                    self.data.append(DestaquesModel(nomeDestaque: "Ler até a madrugada", descricaoDestaque: "Indicações para leitores iniciantes - Recomendações de livros para quem gosta de Aventura", imgDestaque: "livros"))
//                    
//                    
//                    
//                }
//
//            }
            self.delegate?.reloadData(data: self.data)
            self.delegate?.reloadExp(dataExpDestaques: self.dataDestaques)
        }
    }

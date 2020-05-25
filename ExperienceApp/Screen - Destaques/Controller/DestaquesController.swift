//
//  File.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation

protocol DestaquesControllerDelegate: AnyObject {
    func reloadData(data: [DestaquesModel])
}

final class DestaquesController {
    private var data: [DestaquesModel] = []
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
            Cloud.shared.getExperience(data: nil) { (records, error) in

                for record in records {
                    guard (record?["title"]) != nil else { return }
                    guard (record?["description"]) != nil else { return }
                    
                    //Obs.: Aumentar núm. de caracteres
                    self.data.append(DestaquesModel(nomeDestaque: "Ta na Disney?", descricaoDestaque: "Você também é um amante de desenhos? É seu sonho de princesa ter todos os funkos da Disney? Bora ver essas experiências relacionadas com a Disney então!",
                                                imgDestaque: "disney"))
                                     
                                    
                    self.data.append(DestaquesModel(nomeDestaque: "Ler até a madrugada", descricaoDestaque: "Indicações para leitores iniciantes - Recomendações de livros para quem gosta de Aventura", imgDestaque: "livros"))
                }

                self.delegate?.reloadData(data: self.data)
            }
        }
    }

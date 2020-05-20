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
                    
                    self.data.append(DestaquesModel(infoGeralExp: "Experiências voltadas para recomendar livros e clubes de leitura", nomeExp: "Indicações para leitores iniciantes", descricaoExp: "Recomendações de livros para quem gosta de Aventura"))
                }

                self.delegate?.reloadData(data: self.data)
            }
        }
    }

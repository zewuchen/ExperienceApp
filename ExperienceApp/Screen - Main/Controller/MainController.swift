//
//  MainController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation

protocol MainControllerDelegate: AnyObject {
    func reloadData(data: [MainModel])
}

final class MainController {
    private var data: [MainModel] = []
    weak public var delegate: MainControllerDelegate?
    
    public init() {
//        self.data.append(MainModel(nomeDestaque: "Pandas", nomeExp: "Meditacao", descricaoExp: "panda panda panda", notaExp: 9.8, precoExp: "Milhões de dórares"))
//        self.data.append(MainModel(nomeDestaque: "Pandas", nomeExp: "Meditacao", descricaoExp: "panda panda panda", notaExp: 9.8, precoExp: "Milhões de dórares"))
        let _ = Timer.scheduledTimer(timeInterval: 10.0, target: self, selector: #selector(getDataCloud), userInfo: nil, repeats: true)
    }

    @objc func getDataCloud() {
        reload()
        print("buscou os dados")
    }
    
    public func reload() {
        self.data = []
        Cloud.shared.getExperience(data: nil) { (records, error) in

            for record in records {
                guard let name = record?["title"] else { return }
                guard let description = record?["description"] else { return }
                
                self.data.append(MainModel(nomeDestaque: "", nomeExp: name.description, descricaoExp: description.description, notaExp: 10.0, precoExp: "Gratuito"))
            }

            self.delegate?.reloadData(data: self.data)
        }
    }
}

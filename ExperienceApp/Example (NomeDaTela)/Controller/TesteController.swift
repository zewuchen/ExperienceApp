//
//  TesteController.swift
//  ExperienceApp
//
//  Created by Zewu Chen on 14/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

protocol TesteControllerDelegate: AnyObject {
    func reloadData(data: TesteModel)
}

final class TesteController {

    // MARK: Intruções
    // - Há um protocolo que manda os dados para a View (declarar a variável do protocolo aqui no controller)
    // - Final class para ninguém poder herdar esta classe
    // - Funções públicas no controller
    // - Funções do controller chama as funções do protocolo para poder atualizar a view

    private var data: [TesteModel] = []
    weak public var delegate: TesteControllerDelegate?

    public init() {
        self.data.append(TesteModel(id: 1, name: "Juliana", description: "Uma descrição"))
        self.data.append(TesteModel(id: 2, name: "Nathália", description: "Duas descrição"))
        self.data.append(TesteModel(id: 3, name: "Tamara", description: "Três descrição"))
    }

    public func reload() {
        delegate?.reloadData(data: data[Int.random(in: 0...2)])
    }

}

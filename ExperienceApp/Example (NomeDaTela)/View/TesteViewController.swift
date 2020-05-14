//
//  TesteViewController.swift
//  ExperienceApp
//
//  Created by Zewu Chen on 14/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class TesteViewController: UIViewController {

    // MARK: Intruções
    // - Instânciar uma variável com o controller
    // - Dizer para a variável do controller que o delegate dele é a view
    // - Implementar o protocolo com as funções numa extension
    // - Botões chamam as funções do controller, a resposta vem nas funções do protocolo
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!

    private let controller = TesteController()

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        setNavigation()
    }

    func setNavigation() {
        // MARK: Título
        self.navigationItem.title = "Teste"
        // MARK: Cor da Navigation
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
    }

    @IBAction func btnMudar(_ sender: Any) {
        controller.reload()
    }
}

extension TesteViewController: TesteControllerDelegate {
    func reloadData(data: TesteModel) {
        self.label1.text = data.id.description
        self.label2.text = data.name
        self.label3.text = data.description
    }
}

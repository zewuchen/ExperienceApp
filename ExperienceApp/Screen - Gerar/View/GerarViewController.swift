//
//  GerarViewController.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class GerarViewController: UIViewController {

    // TODO: Adicionar fotos
    // TODO: Adicionar disponibilidade
    @IBOutlet weak var txtTema: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    @IBOutlet weak var txtTamanho: UITextField!
    @IBOutlet weak var txtRecursos: UITextField!
    @IBOutlet weak var txtParticipar: UITextField!

    private let controller = GerarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
    }

    @IBAction func btnCreateExperience(_ sender: Any) {
        if validate() {
            guard let title = txtTema.text else { return }
            guard let description = txtDescription.text else { return }
            guard let howToParticipate = txtParticipar.text else { return }
            guard let whatToTake = txtParticipar.text else { return }
            guard let tamanho = txtTamanho.text else { return }
            guard let lengthGroup = Int64(tamanho) else { return }
            
            let experience = ExperienceModel(title: title, description: description, howToParticipate: howToParticipate, lengthGroup: lengthGroup, whatToTake: whatToTake)

            controller.createExperience(data: experience)
        }
    }

    func validate() -> Bool {
        // TODO: Validar os campos de dados aqui
        return true
    }

}

extension GerarViewController: GerarControllerDelegate {
    func reload() {
        // TODO: Fazer algo
    }
}

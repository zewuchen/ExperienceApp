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
        print(UserDefaults.standard.object(forKey: "name"))
        let toque = UITapGestureRecognizer(target: self, action: #selector(tirarTeclado))
        self.view.addGestureRecognizer(toque)
        toque.cancelsTouchesInView = false
    }

    @IBAction func btnCreateExperience(_ sender: Any) {
        
        if validate() {
            guard let title = txtTema.text else { return }
            guard let description = txtDescription.text else { return }
            guard let tamanho = txtTamanho.text else { return }
            guard let lengthGroup = Int64(tamanho) else { return }
            guard let howToParticipate = txtParticipar.text else { return }
            guard let whatToTake = txtParticipar.text else { return }
            
            let experience = ExperienceModel(title: title, description: description, howToParticipate: howToParticipate, lengthGroup: lengthGroup, whatToTake: whatToTake)

            controller.createExperience(data: experience)
        }
    }
    
    @objc func tirarTeclado() {
        self.view.endEditing(true)
    }
    
    //nenhum campo seja nulo
    //tamanho limite seja do tipo numerico - so posso por numero
    //add fotos -> modificar design
    //tocar fora no teclado
    
    func validate() -> Bool {
        // TODO: Validar os campos de dados aqui
        let corBorda = UIColor.red.cgColor
        let corBorda2 = UIColor.init(red: 1.83, green: 0.77, blue: 0.77, alpha: 1.0).cgColor
        
        if txtTema.text == "" || txtTema.text == nil {
            print("faltam dados")
            
            txtTema.layer.borderColor = corBorda2
            txtTema.layer.borderWidth = 2.0
            txtTema.layer.cornerRadius = 6
            return false
        }
        return true
    }
}

extension GerarViewController: GerarControllerDelegate {
    func reload() {
        // TODO: Fazer algo
    }
}

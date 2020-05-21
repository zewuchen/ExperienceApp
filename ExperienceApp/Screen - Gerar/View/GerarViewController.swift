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
    let corBordaCerta = UIColor.lightGray.cgColor
    let corBordaErrada = UIColor.init(red: 1.83, green: 0.77, blue: 0.77, alpha: 1.0).cgColor
    var arrayReturn: [Bool] = []
    let border = 0.25
    
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
            guard let whatToTake = txtRecursos.text else { return }
            
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
        arrayReturn = []
        
        // Validando Texto Tema
        if txtTema.text == "" || txtTema.text == nil || txtTema.text?.count ?? 1 > 50 {
            txtTema.layer.borderColor = corBordaErrada
            txtTema.layer.borderWidth = 2.0
            txtTema.layer.cornerRadius = 6
            arrayReturn.append(false)
        } else {
            txtTema.layer.borderColor = corBordaCerta
            txtTema.layer.borderWidth = 0.25
            arrayReturn.append(true)
        }
        
        
        // Validando Texto Descrição
        // TODO: quantidade de caracteres
        if txtDescription.text == "" || txtDescription.text == nil || txtDescription.text?.count ?? 1 > 240 {
            txtDescription.layer.borderColor = corBordaErrada
            txtDescription.layer.borderWidth = 2.0
            txtDescription.layer.cornerRadius = 6
            arrayReturn.append(false)
        } else {
            txtDescription.layer.borderColor = corBordaCerta
//            print(txtDescription.text?.count ?? "juu")
            txtDescription.layer.borderWidth = 0.25
            arrayReturn.append(true)
        }
        
        
        // Validando Texto Tamanhos
        let validacaoTamanho = verificarTam()
        arrayReturn.append(validacaoTamanho)

        if let num = Int(txtTamanho.text!) {
            if num > 50 || num <= 0 {
                txtTamanho.layer.borderColor = corBordaErrada
                txtTamanho.layer.borderWidth = 2.0
                txtTamanho.layer.cornerRadius = 6
                arrayReturn.append(false)
            } else {
                txtTamanho.layer.borderColor = corBordaCerta
                txtTamanho.layer.borderWidth = 0.25
                arrayReturn.append(true)
            }
        }
        
        
        // Validando Texto HowToParticipate
        if txtParticipar.text == "" || txtParticipar.text == nil || txtParticipar.text?.count ?? 1 > 240 {
            txtParticipar.layer.borderColor = corBordaErrada
            txtParticipar.layer.borderWidth = 2.0
            txtParticipar.layer.cornerRadius = 6
            arrayReturn.append(false)
        } else {
            txtParticipar.layer.borderColor = corBordaCerta
            txtParticipar.layer.borderWidth = 0.25
            arrayReturn.append(true)
        }
        
        // Validando Texto Recursos
        if txtRecursos.text == "" || txtRecursos.text == nil || txtRecursos.text?.count ?? 1 > 240 {
            txtRecursos.layer.borderColor = corBordaErrada
            txtRecursos.layer.borderWidth = 2.0
            txtRecursos.layer.cornerRadius = 6
            arrayReturn.append(false)
        } else {
            txtRecursos.layer.borderColor = corBordaCerta
            txtRecursos.layer.borderWidth = 0.25
            arrayReturn.append(true)
        }

        if arrayReturn.contains(false) {
            return false
        } else {
            return true
        }
    }
    
    func verificarTam() -> Bool {
        let letras = NSCharacterSet.letters
        if txtTamanho.text == "" || txtTamanho.text == nil {
            txtTamanho.layer.borderColor = corBordaErrada
            txtTamanho.layer.borderWidth = 2.0
            txtTamanho.layer.cornerRadius = 6
            return false
        } else {
            if let range = txtTamanho.text?.rangeOfCharacter(from: letras) {
                txtTamanho.layer.borderColor = corBordaErrada
                txtTamanho.layer.borderWidth = 2.0
                txtTamanho.layer.cornerRadius = 6
                return false
            }
            txtTamanho.layer.borderColor = corBordaCerta
            txtTamanho.layer.borderWidth = 0.25
            return true
        }
    }
}

extension GerarViewController: GerarControllerDelegate {
    func reload() {
        // TODO: Fazer algo
    }
}

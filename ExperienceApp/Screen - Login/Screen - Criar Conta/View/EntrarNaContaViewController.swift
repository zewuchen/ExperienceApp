//
//  EntrarNaContaViewController.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class EntrarNaContaViewController: UIViewController {

    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtDescription: UITextField!

    let controller = CreateAccountController()

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        let toque = UITapGestureRecognizer(target: self, action: #selector(tirarTeclado))
        self.view.addGestureRecognizer(toque)
        toque.cancelsTouchesInView = false
    }
    
    @objc func tirarTeclado() {
        self.view.endEditing(true)
    }

    @IBAction func btnCreateAccount(_ sender: Any) {
        guard let name = txtNome.text else { return }
        guard let email = txtEmail.text else { return }
        guard let password = txtSenha.text else { return }
        guard let description = txtDescription.text else { return }

        let user = AuthModel(name: name, description: description, email: email, password: password)
        controller.createAccount(user: user)
    }

    @IBAction func btnLogin(_ sender: Any) {
            let novaTela = CriarContaViewController(nibName: "CriarContaViewController", bundle: nil)
           novaTela.modalPresentationStyle = .fullScreen
           self.present(novaTela, animated: true, completion: nil)
        

    }
}

extension EntrarNaContaViewController: CreateAccountControllerDelegate {
    func authResponser() {
        // TODO: Fazer algo
        // TODO: Mostrar sucesso pro usuário ou erro
    }
}

//
//  CriarContaViewController.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class CriarContaViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!

    let controller = LoginController()

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
           controller.delegate = self
            let toque = UITapGestureRecognizer(target: self, action: #selector(tirarTeclado))
            self.view.addGestureRecognizer(toque)
            toque.cancelsTouchesInView = false
        }
        @objc func tirarTeclado() {
            self.view.endEditing(true)
        }

    @IBAction func btnLogin(_ sender: Any) {
        guard let email = txtEmail.text else { return }
        guard let password = txtSenha.text else { return }

        let user = AuthModel(name: "", description: "", email: email, password: password, image: "")
        controller.login(user: user)
        self.navigationController?.popToRootViewController(animated: false)
    }
}

extension CriarContaViewController: LoginControllerDelegate {
    func authResponser() {
        // TODO: Fazer algo
        // TODO: Mostrar sucesso pro usuário ou erro
    }
}

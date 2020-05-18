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
    }

    @IBAction func btnLogin(_ sender: Any) {
        // TODO: Mostrar sucesso pro usuário ou erro
    }

}

extension CriarContaViewController: LoginControllerDelegate {
    func authResponser() {
        // TODO: Fazer algo
    }
}

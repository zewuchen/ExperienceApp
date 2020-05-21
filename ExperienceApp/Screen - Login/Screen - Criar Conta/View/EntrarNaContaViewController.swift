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
    @IBOutlet weak var imageView: UIImageView!

    let controller = CreateAccountController()
    var urlString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        let toque = UITapGestureRecognizer(target: self, action: #selector(tirarTeclado))
        self.view.addGestureRecognizer(toque)
        let selectorImage = UITapGestureRecognizer(target: self, action: #selector(addImage))
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(selectorImage)
        toque.cancelsTouchesInView = false
    }
    
    @objc func tirarTeclado() {
        self.view.endEditing(true)
    }

    @objc func addImage() {
        controller.setImage()
    }

    @IBAction func btnCreateAccount(_ sender: Any) {
        guard let name = txtNome.text else { return }
        guard let email = txtEmail.text else { return }
        guard let password = txtSenha.text else { return }
        guard let description = txtDescription.text else { return }

        let user = AuthModel(name: name, description: description, email: email, password: password, image: urlString)
        controller.createAccount(user: user)
        self.navigationController?.popToRootViewController(animated: false)
    }

    @IBAction func btnLogin(_ sender: Any) {
            let novaTela = CriarContaViewController(nibName: "CriarContaViewController", bundle: nil)
      //     novaTela.modalPresentationStyle = .fullScreen
           self.present(novaTela, animated: true, completion: nil)
    }
}

extension EntrarNaContaViewController: CreateAccountControllerDelegate {
    func setImageProfile() {
        Camera().selecionadorImagem(self){ imagem in
            self.imageView.image = imagem

            if self.urlString != "" {
                self.controller.deleteFoto(fileURL: self.urlString)
            }

            self.urlString = self.controller.saveFoto(imagem: self.imageView.image ?? UIImage())
        }
    }

    func authResponser() {
        // TODO: Fazer algo
        // TODO: Mostrar sucesso pro usuário ou erro
    }
}

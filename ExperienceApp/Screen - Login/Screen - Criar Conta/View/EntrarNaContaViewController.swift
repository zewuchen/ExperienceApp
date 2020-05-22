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
        setUpPlaceholder()
        setImage()
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
        
        if validar() {
            guard let name = txtNome.text else { return }
            guard let email = txtEmail.text else { return }
            guard let password = txtSenha.text else { return }
            guard let description = txtDescription.text else { return }

            let user = AuthModel(name: name, description: description, email: email, password: password, image: urlString)
            controller.createAccount(user: user)
            self.navigationController?.popToRootViewController(animated: false)
        }
        
    }
    
    func validarEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validar() -> Bool {
        let corBordaCerta = UIColor.lightGray.cgColor
        let corBordaErrada = UIColor.init(red: 1.83, green: 0.77, blue: 0.77, alpha: 1.0).cgColor
        var arrayReturn: [Bool] = []
        
        
        // Validar nome
        if txtNome.text == "" || txtNome.text == nil || txtNome.text?.count ?? 1 > 42 {
            txtNome.layer.borderColor = corBordaErrada
            txtNome.layer.borderWidth = 2.0
            txtNome.layer.cornerRadius = 6
            arrayReturn.append(false)
        } else {
            txtNome.layer.borderColor = corBordaCerta
            txtNome.layer.borderWidth = 0.25
            arrayReturn.append(true)
        }
        
        // Validar e-mail
        if txtEmail.text == "" || txtEmail.text == nil || validarEmail(txtEmail.text ?? "email") == false {
            txtEmail.layer.borderColor = corBordaErrada
            txtEmail.layer.borderWidth = 2.0
            txtEmail.layer.cornerRadius = 6
            arrayReturn.append(false)
        } else {
            txtEmail.layer.borderColor = corBordaCerta
            txtEmail.layer.borderWidth = 0.25
            arrayReturn.append(true)
        }
        
        
        // Validar password
        if txtSenha.text == "" || txtSenha.text == nil {
            txtSenha.layer.borderColor = corBordaErrada
            txtSenha.layer.borderWidth = 2.0
            txtSenha.layer.cornerRadius = 6
            arrayReturn.append(false)
        } else {
            txtSenha.layer.borderColor = corBordaCerta
            txtSenha.layer.borderWidth = 0.25
            arrayReturn.append(true)
        }
        
        
        // Validar biografia/description
        if txtDescription.text == "" || txtDescription.text == nil || txtDescription.text?.count ?? 1 > 240 {
            txtDescription.layer.borderColor = corBordaErrada
            txtDescription.layer.borderWidth = 2.0
            txtDescription.layer.cornerRadius = 6
            arrayReturn.append(false)
        } else {
            txtDescription.layer.borderColor = corBordaCerta
            txtDescription.layer.borderWidth = 0.25
            arrayReturn.append(true)
        }
        
        
        if arrayReturn.contains(false) {
            return false
        }
        return true
    }

    @IBAction func btnLogin(_ sender: Any) {
            let novaTela = CriarContaViewController(nibName: "CriarContaViewController", bundle: nil)
      //     novaTela.modalPresentationStyle = .fullScreen
           self.present(novaTela, animated: true, completion: nil)
    }
    
    func setUpPlaceholder() {
        let color = #colorLiteral(red: 0.7675922513, green: 0.7630307674, blue: 0.7710996866, alpha: 1)
        
        txtNome.attributedPlaceholder = NSAttributedString(string: "Insira seu nome completo", attributes: [NSAttributedString.Key.foregroundColor: color])
        txtEmail.attributedPlaceholder = NSAttributedString(string: "Insira seu e-mail", attributes: [NSAttributedString.Key.foregroundColor: color])
        txtSenha.attributedPlaceholder = NSAttributedString(string: "Insira sua senha", attributes: [NSAttributedString.Key.foregroundColor: color])
        txtDescription.attributedPlaceholder = NSAttributedString(string: "Fale um pouco sobre você", attributes: [NSAttributedString.Key.foregroundColor: color])
    }
    
    @IBAction func sairBtn(_ sender: Any) {
//        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        self.dismiss(animated: true, completion: nil)
    }
    
    func setImage() {
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
        imageView.layer.shadowOpacity = 0.04
        imageView.layer.shadowRadius = 1.0
        imageView.clipsToBounds = false
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

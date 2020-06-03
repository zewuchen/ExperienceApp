//
//  EntrarNaContaViewController.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class EntrarNaContaViewController: UIViewController {

    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var btnEntrar: UIButton!
    
    let controller = LoginController()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPlaceholder()
        setUpButton()
        controller.delegate = self
        controller.delegate = self
        let toque = UITapGestureRecognizer(target: self, action: #selector(tirarTeclado))
        self.view.addGestureRecognizer(toque)
        toque.cancelsTouchesInView = false
    }
    
    func setUpButton() {
        btnEntrar.layer.cornerRadius = 10
    }
    
    @objc func tirarTeclado() {
        self.view.endEditing(true)
    }

    @IBAction func btnLogin(_ sender: Any) {
        
        if validar() {
            guard let email = txtEmail.text else { return }
            guard let password = txtSenha.text else { return }

            let user = AuthModel(name: "", description: "", email: email, password: password, image: "")
            controller.login(user: user)
//            self.dismiss(animated: false, completion: nil)
            
            let telaLogar = LoginPopViewController()
            telaLogar.modalTransitionStyle  =  .crossDissolve
            telaLogar.modalPresentationStyle = .overCurrentContext
            self.present(telaLogar, animated: false, completion: nil)
        }
    }
    
    func validarEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validar() -> Bool {
        var arrayReturn: [Bool] = []
        let corBordaErrada = UIColor.init(red: 1.83, green: 0.77, blue: 0.77, alpha: 1.0).cgColor
        let corBordaCerta = UIColor.lightGray.cgColor
        
        if txtEmail.text == "" || txtEmail.text == nil || validarEmail(txtEmail.text ?? "email") == false {
            txtEmail.layer.borderColor = corBordaErrada
            txtEmail.layer.borderWidth = 2.0
            txtEmail.layer.cornerRadius = 5
            arrayReturn.append(false)
        } else {
            txtSenha.layer.borderColor = corBordaCerta
            txtSenha.layer.borderWidth = 0.25
            arrayReturn.append(true)
        }
        
        if txtSenha.text == "" || txtSenha.text == nil {
            txtSenha.layer.borderColor = corBordaErrada
            txtSenha.layer.borderWidth = 2.0
            txtSenha.layer.cornerRadius = 5
            arrayReturn.append(false)
        } else {
            txtSenha.layer.borderColor = corBordaCerta
            txtSenha.layer.borderWidth = 0.25
            arrayReturn.append(true)
        }
        
        if arrayReturn.contains(false) {
            //TODO: pop-up de erro?
            return false
        }
        
        return true
    }
    
    func setUpPlaceholder() {
        let color = #colorLiteral(red: 0.7675922513, green: 0.7630307674, blue: 0.7710996866, alpha: 1)
        txtEmail.attributedPlaceholder = NSAttributedString(string: "Insira seu e-mail", attributes: [NSAttributedString.Key.foregroundColor: color])
        txtSenha.attributedPlaceholder = NSAttributedString(string: "Insira sua senha", attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}

extension EntrarNaContaViewController: LoginControllerDelegate {
    func authResponser() {
        // TODO: Fazer algo
        // TODO: Mostrar sucesso pro usuário ou erro
    }
}

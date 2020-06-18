//
//  CriarContaViewController.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class CriarContaViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {

    @IBOutlet weak var txtNome: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtSenha: UITextField!
    @IBOutlet weak var txtDescription: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var btnCriarConta: UIButton!
    @IBOutlet weak var scrollViewCriarConta: UIScrollView!
    
    let controller = CreateAccountController()
    var urlString = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPlaceholder()
        setImage()
        controller.delegate = self
        setUpBiography()
        setUpButton()
        txtNome.delegate = self
        scrollViewCriarConta.delegate = self
        
//        NotificationCenter.default.addObserver(self, selector: #selector(aparecerTeclado), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(esconderTeclado), name: UIResponder.keyboardWillHideNotification, object: nil)
        let toque = UITapGestureRecognizer(target: self, action: #selector(tirarTeclado))
        self.view.addGestureRecognizer(toque)
        let selectorImage = UITapGestureRecognizer(target: self, action: #selector(addImage))
        self.imageView.isUserInteractionEnabled = true
        self.imageView.addGestureRecognizer(selectorImage)
        toque.cancelsTouchesInView = false
    }
    
    func setUpButton () {
        btnCriarConta.layer.cornerRadius = 10
    }
    
    @objc func aparecerTeclado(notification: NSNotification) {
        guard let tamTeclado = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if self.view.frame.origin.y == 0 {
            view.frame.origin.y = -tamTeclado.height
        }
        
    }

    @objc func esconderTeclado(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
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
            
            let telaContaCriada = LoginCriarPopViewController()
            telaContaCriada.modalTransitionStyle  =  .crossDissolve
            telaContaCriada.modalPresentationStyle = .overCurrentContext
            self.present(telaContaCriada, animated: false, completion: nil)
        }
    }

    func validarEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func validar() -> Bool {
        let corBordaCerta = UIColor.lightGray.cgColor
        let corBordaErrada = UIColor.init(red: 0.5915914774, green: 0, blue: 0.2114774585, alpha: 1.0).cgColor
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
        if txtDescription.text == "" || txtDescription.text == nil || txtDescription.text?.count ?? 1 > 300 {
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
        let novaTela = EntrarNaContaViewController(nibName: "EntrarNaContaViewController", bundle: nil)
        
        self.present(novaTela, animated: true, completion: nil)
    }
    
    func setUpPlaceholder() {
        let color = #colorLiteral(red: 0.7675922513, green: 0.7630307674, blue: 0.7710996866, alpha: 1)
        
        txtNome.attributedPlaceholder = NSAttributedString(string: "Insira seu nome completo", attributes: [NSAttributedString.Key.foregroundColor: color])
        txtEmail.attributedPlaceholder = NSAttributedString(string: "Insira seu e-mail", attributes: [NSAttributedString.Key.foregroundColor: color])
        txtSenha.attributedPlaceholder = NSAttributedString(string: "Insira sua senha", attributes: [NSAttributedString.Key.foregroundColor: color])
        //        txtDescription.attributedPlaceholder = NSAttributedString(string: "Fale um pouco sobre você", attributes: [NSAttributedString.Key.foregroundColor: color])
        
        txtDescription.text = "Fale um pouco sobre você"
        txtDescription.textColor = UIColor.lightGray
        txtDescription.font = UIFont(name: "avenir", size: 16.0)
        txtDescription.returnKeyType = .done
        txtDescription.delegate = self
        txtDescription.backgroundColor = UIColor.white
        //Borda
        txtDescription.layer.borderColor = UIColor.lightGray.cgColor
        txtDescription.layer.borderWidth = 0.5
      // txtDescription.layer.cornerRadius = 15
  
    }
    
    func setUpBiography() {
        txtDescription.layer.cornerRadius = 6
        txtDescription.allowsEditingTextAttributes = false
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        if textField == txtNome || textField == txtEmail || textField == txtSenha {
            NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        }
        return true
    }
    
    // MARK: UITextViewDelegates
    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if textView == txtDescription {
            NotificationCenter.default.addObserver(self, selector: #selector(aparecerTeclado), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(esconderTeclado), name: UIResponder.keyboardWillHideNotification, object: nil)
        }
        return true
    }
   
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Fale um pouco sobre você" {
            textView.text = ""
//            textView.textColor = UIColor(red: 183, green: 77, blue: 77, alpha: 1)
            textView.textColor = UIColor.black
            textView.font = UIFont(name: "avenir", size: 16.0)
        }
    }
       
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return true
    }
       
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Fale um pouco sobre você"
            textView.textColor = UIColor.lightGray
            textView.font = UIFont(name: "avenir", size: 16.0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setImage() {
        imageView.layer.shadowColor = UIColor.black.cgColor
        imageView.layer.shadowOffset = CGSize(width: 4, height: 4)
        imageView.layer.shadowOpacity = 0.04
        imageView.layer.shadowRadius = 1.0
        imageView.clipsToBounds = false
    }
    
    @IBAction func btnTermsOfUse(_ sender: Any) {
        let termosDeUso = TermosDeUsoViewController()
        termosDeUso.modalTransitionStyle  =  .crossDissolve
        termosDeUso.modalPresentationStyle = .overCurrentContext
        self.present(termosDeUso, animated: false, completion: nil)
    }
}

extension CriarContaViewController: CreateAccountControllerDelegate {
    func setImageProfile() {
        Camera().selecionadorImagem(self) { imagem in
            self.imageView.image = imagem
            self.imageView.contentMode = .scaleAspectFit

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

extension CriarContaViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.bounces = scrollView.contentOffset.y > 100
    }
}

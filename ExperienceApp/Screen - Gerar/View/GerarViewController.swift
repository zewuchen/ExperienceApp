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
    @IBOutlet weak var imgFoto: UIImageView!
    @IBOutlet weak var txtData: UITextField!
    
    private var dataPicker: UIDatePicker?
    private let controller = GerarController()
    let corBordaCerta = UIColor.lightGray.cgColor
    let corBordaErrada = UIColor.init(red: 1.83, green: 0.77, blue: 0.77, alpha: 1.0).cgColor
    var arrayReturn: [Bool] = []
    var urlString = ""
    var data: Date = Date()
    let border = 0.25
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigation()
        controller.delegate = self
        setUpPicker()
        let toque = UITapGestureRecognizer(target: self, action: #selector(tirarTeclado))
        self.view.addGestureRecognizer(toque)
        toque.cancelsTouchesInView = false
        let selectorImage = UITapGestureRecognizer(target: self, action: #selector(addImage))
        self.imgFoto.isUserInteractionEnabled = true
        self.imgFoto.addGestureRecognizer(selectorImage)
        
        NotificationCenter.default.addObserver(self, selector: #selector(aparecerTeclado), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(esconderTeclado), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func aparecerTeclado(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }

    @IBAction func sairBtn(_ sender: Any) {
        dismissTela()
    }
    
    @objc func dismissTela() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func esconderTeclado(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func setUpPicker() {
        dataPicker = UIDatePicker()
        dataPicker?.locale = Locale(identifier: "pt")
        dataPicker?.datePickerMode = .date
        dataPicker?.addTarget(self, action: #selector(mudarData), for: .valueChanged)
        txtData.inputView = dataPicker
    }
    
    @objc func mudarData(dataPicker: UIDatePicker) {
        let formatarData = DateFormatter()
        formatarData.dateFormat = "dd/MM/yyyy"
        txtData.text = formatarData.string(from: dataPicker.date)
        formatarData.dateFormat = "YYYY-MM-DD HH:mm:ss"
        self.data = dataPicker.date
    }

    @objc func addImage() {
        controller.setImage()
    }

    @IBAction func btnCreateExperience(_ sender: Any) {
        if validate() {
            guard let title = txtTema.text else { return }
            guard let description = txtDescription.text else { return }
            guard let tamanho = txtTamanho.text else { return }
            guard let lengthGroup = Int64(tamanho) else { return }
            guard let howToParticipate = txtParticipar.text else { return }
            guard let whatToTake = txtRecursos.text else { return }
            
            let experience = ExperienceModel(title: title, description: description, recordName: nil, date: self.data, howToParticipate: howToParticipate, lengthGroup: lengthGroup, whatToTake: whatToTake, image: urlString)
            
                controller.createExperience(data: experience)
            
            // Ir para o PopUp
            let telaExpCriada = ExpCriadaPopUp()
               telaExpCriada.modalTransitionStyle  =  .crossDissolve
               telaExpCriada.modalPresentationStyle = .overCurrentContext
               self.present(telaExpCriada, animated: true, completion: nil)
            
//            let _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(dismissTela), userInfo: nil, repeats: true)
            // TODO: Dar dismiss na tela quando criar a experiência
//            self.navigationController?.popToRootViewController(animated: false)
        }
    }
    
    @objc func tirarTeclado() {
        self.view.endEditing(true)
    }
    
    func setNavigation() {
        // MARK: Título
//        self.navigationItem.title = "Teste"
        // MARK: Cor da Navigation
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = #colorLiteral(red: 0.9921568627, green: 0.9921568627, blue: 0.9921568627, alpha: 1)
    }
    
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

        // Validando Imagem
        if self.urlString == "" {
            self.imgFoto.layer.borderColor = corBordaErrada
            self.imgFoto.layer.borderWidth = 2.0
            arrayReturn.append(false)
        } else {
            self.imgFoto.layer.borderColor = corBordaCerta
            self.imgFoto.layer.borderWidth = 0.25
            arrayReturn.append(true)
        }

        // Validando a data com um intervalo de 5 minutos a frente
        if self.data.addingTimeInterval(TimeInterval(5.0 * 60.0)) <= Date() {
            self.txtData.layer.borderColor = corBordaErrada
            self.txtData.layer.borderWidth = 2.0
            arrayReturn.append(false)
        } else {
            self.txtData.layer.borderColor = corBordaCerta
            self.txtData.layer.borderWidth = 0.25
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
    func setImageProfile() {
        Camera().selecionadorImagem(self) { imagem in
            self.imgFoto.image = imagem

            if self.urlString != "" {
                self.controller.deleteFoto(fileURL: self.urlString)
            }

            self.urlString = self.controller.saveFoto(imagem: self.imgFoto.image ?? UIImage())
        }
    }

    func reload() {
        // TODO: Fazer algo
    }
}

//
//  TelaAdmViewController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 25/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class TelaAdmViewController: UIViewController {

    //Outlets
    @IBOutlet weak var txtFieldTemaDestaque: UITextField!
    @IBOutlet weak var txtFieldDescricaoDestaque: UITextField!
    @IBOutlet weak var tableViewExpEscolhidas: UITableView!
    @IBOutlet weak var btnEnviar: UIButton!
    
    public var data: [DestaquesModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnEnviar.layer.cornerRadius = 10
        setNavigation()
        setKeyboard()
    }
    
    @IBAction func btnCriarDestaque() {
        if validar() {
            guard let tema = txtFieldTemaDestaque.text else { return }
            guard let descricao = txtFieldDescricaoDestaque.text else { return }
            
        }
    }
    
    func setKeyboard() {
        let toque = UITapGestureRecognizer(target: self, action: #selector(tirarTeclado))
        self.view.addGestureRecognizer(toque)
        toque.cancelsTouchesInView = false
    }
    
    @objc func tirarTeclado() {
        self.view.endEditing(true)
    }
    
    @objc func aparecerTeclado(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func esconderTeclado(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func validar() -> Bool{
        //TODO: Validar entradas
        return true
    }
}

//extension TelaAdmViewController: TemaControllerDelegate {
//    
//}

extension TelaAdmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = self.tableViewExpEscolhidas.dequeueReusableCell(withIdentifier: "DestaquesTableViewCell", for: indexPath) as? DestaquesTableViewCell
        celula?.setUpCriarDestaques(model: data[indexPath.row])
        return celula ?? UITableViewCell()
    }
    
    
}

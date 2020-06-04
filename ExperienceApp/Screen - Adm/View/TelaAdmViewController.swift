//
//  TelaAdmViewController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 25/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class TelaAdmViewController: UIViewController, UITableViewDelegate {

    //Outlets
    @IBOutlet weak var txtFieldTemaDestaque: UITextField!
    @IBOutlet weak var txtFieldDescricaoDestaque: UITextField!
    @IBOutlet weak var tableViewExpEscolhidas: UITableView!
    @IBOutlet weak var btnEnviar: UIButton!
    @IBOutlet weak var imgAdd: UIImageView!
    
    var urlString = ""
    
    public var data: [MainModel] = []
    var expSelecionadas: [String] = []
    private let controller = TelaAdmController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        btnEnviar.layer.cornerRadius = 10
        controller.reload()
        controller.delegate = self
        setNavigation()
        setKeyboard()
        setUpTable()
        setAddImage()
    }
    
    func setUpTable() {
        tableViewExpEscolhidas.dataSource = self
        tableViewExpEscolhidas.delegate = self
        tableViewExpEscolhidas.register(UINib(nibName: "RecomendacoesTableViewCell", bundle: nil), forCellReuseIdentifier: "RecomendacoesTableViewCell")
    }
    
    func setAddImage() {
        let selectorImg = UITapGestureRecognizer(target: self, action: #selector(addImg))
        
        self.imgAdd.isUserInteractionEnabled = true
        self.imgAdd.addGestureRecognizer(selectorImg)
    }
    
    @objc func addImg() {
        controller.setImage()
    }
    
    @IBAction func btnCriarDestaque() {
        if validar() {
            guard let tema = txtFieldTemaDestaque.text else { return }
            guard let descricao = txtFieldDescricaoDestaque.text else { return }
            let data = HighlightModel(title: tema, description: descricao, image: urlString, experiences: expSelecionadas)
            controller.createHighlight(data: data)
            let alert = UIAlertController(title: nil, message: "Criando destaque...", preferredStyle: .alert)
            let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
            loadingIndicator.hidesWhenStopped = true
            loadingIndicator.style = UIActivityIndicatorView.Style.gray
            loadingIndicator.startAnimating()
            alert.view.addSubview(loadingIndicator)
            present(alert, animated: true, completion: nil)

            let when = DispatchTime.now() + 5
            DispatchQueue.main.asyncAfter(deadline: when) {
              alert.dismiss(animated: true, completion: nil)
                self.dismiss(animated: true, completion: nil)
            }
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
    
    @IBAction func sairBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func setNavigation() {
        navigationController?.navigationBar.isHidden = true
    }
    
    func validar() -> Bool{
        //TODO: Validar entradas
        return true
    }
    
    func setImageProfile() {
        Camera().selecionadorImagem(self) {
            imagem in
            self.imgAdd.image = imagem
            self.imgAdd.contentMode = .scaleAspectFit
            
            if self.urlString != ""{
                self.controller.deleteFoto(fileURL: self.urlString)
            }
            
            self.urlString = self.controller.salvarFoto(imagem: self.imgAdd.image ?? UIImage())
        }
    }
}

extension TelaAdmViewController: TelaAdmControllerDelegate {
    func reloadData(data: [MainModel]) {
        self.data = data
        DispatchQueue.main.async {
            self.tableViewExpEscolhidas.reloadData()
        }
    }
}

extension TelaAdmViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celula = self.tableViewExpEscolhidas.dequeueReusableCell(withIdentifier: "RecomendacoesTableViewCell", for: indexPath) as? RecomendacoesTableViewCell
        celula?.setUp(model: data[indexPath.row])
        
        return celula ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.data[indexPath.row].isSelected = !self.data[indexPath.row].isSelected

        let celula = self.tableViewExpEscolhidas.cellForRow(at: indexPath) as? RecomendacoesTableViewCell

        if let index = expSelecionadas.firstIndex(of: celula?.recordName ?? "Vazio") {
            celula?.titleCard?.textColor = .black
            expSelecionadas.remove(at: index)
        } else {
            if expSelecionadas.count < 3 {
                celula?.titleCard?.textColor = .vermelhoTijolo
                expSelecionadas.append(celula?.recordName ?? "Vazio")
            }
        }
    }
}

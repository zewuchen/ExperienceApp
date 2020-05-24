//
//  MainViewController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var btnPerfil: UIButton!
    @IBOutlet weak var btnBusca: UIButton!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    
    private var data: [MainModel] = []
    
    private let controller = MainController()
    
    let recomendacoesCell = "RecomendacoesTableViewCell"
    let destaquesCell = "DestaquesCollectionViewCell"
    
    //stayHome, Livros, Jogos, Água
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        setUpTable()
        setUpButtons(button: btnBusca, nome: "busca.png")
        setUpButtons(button: btnPerfil, nome: "userDefault")
        setUpCollection()
        controller.reload()

        // Desabilitado o botão de procurar aqui
        btnBusca.removeFromSuperview()
        setNavigation()
    }
    
    func setUpTable() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: recomendacoesCell, bundle: nil), forCellReuseIdentifier: recomendacoesCell)
        tableView.separatorStyle = .none
    }
    
    func setUpCollection() {
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: destaquesCell, bundle: nil), forCellWithReuseIdentifier: destaquesCell)
    }
    
    func setNavigation() {
        // MARK: Título
//        self.navigationItem.title = "Teste"
        // MARK: Cor da Navigation
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = .clear
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setUpButtons(button: UIButton, nome: String) {
        button.layer.cornerRadius = 22.5
        button.layer.masksToBounds = true
        button.setImage(UIImage(named: nome), for: .normal)

        if let nameImage = UserDefaults.standard.string(forKey: "image") {
            if let imagePath = FileHelper.getFile(filePathWithoutExtension: nameImage) {
                let image = UIImage(contentsOfFile: imagePath)
                button.setImage(image, for: .normal)
            }
        }
    }

    @IBAction func btnPerfilAction(_ sender: Any) {
        var novaTela = UIViewController()
        if !UserDefaults.standard.bool(forKey: "logged") {
            novaTela = LoginViewController(nibName: "LoginViewController", bundle: nil)
            novaTela.modalPresentationStyle = .fullScreen
        } else {
            novaTela = PerfilViewController(nibName: "PerfilViewController", bundle: nil)
            novaTela.modalPresentationStyle = .fullScreen
        }
        self.present(novaTela, animated: true, completion: nil)
    }

}

extension MainViewController: MainControllerDelegate {
    func reloadData(data: [MainModel]) {
        self.data = data
        DispatchQueue.main.async {
            self.collectionView.reloadData()
            self.tableView.reloadData()
        }
    }
}

extension MainViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        data.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let celulaCollection = collectionView.dequeueReusableCell(withReuseIdentifier: destaquesCell, for: indexPath) as? DestaquesCollectionViewCell
        
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
        }
        
        celulaCollection?.setUp(model: data[indexPath.row])
        return celulaCollection ?? UICollectionViewCell()
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let celulaTable = RecomendacoesTableViewCell(style: .default, reuseIdentifier: recomendacoesCell)
    
        let celulaTable = self.tableView.dequeueReusableCell(withIdentifier: recomendacoesCell, for: indexPath) as? RecomendacoesTableViewCell
        
        celulaTable?.setUp(model: data[indexPath.row])
    
        return celulaTable ?? UITableViewCell()
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let novaTela = ExperienciasInfoViewController(nibName: "ExperienciasInfoViewController", bundle: nil)
        novaTela.modalPresentationStyle = .fullScreen
        novaTela.controller.dataToConvert = data[indexPath.row]
        self.present(novaTela, animated: true, completion: nil)
    }
}

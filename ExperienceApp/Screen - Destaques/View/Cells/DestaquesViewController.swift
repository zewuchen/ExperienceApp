//
//  DestaquesViewController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class DestaquesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var lblDestaque: UILabel!
    @IBOutlet weak var imgDestaque: UIImageView!
    @IBOutlet weak var infoDestaque: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomTableView: NSLayoutConstraint!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    // MARK: Variáveis
    let destaquesCell = "DestaquesTableViewCell"
//    var numberOfRows: Int = 2
    
    public var data: DestaquesModel?
    private var dataExpDestaques: [ExperienciaDestaquesModel] = []
    
    private let controller = DestaquesController()
    var tururu = ["oi", "tudo", "bem"]
       
     // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setNavigation()
        controller.delegate = self
        scrollView.delegate = self
        controller.reload()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblDestaque.text = data?.nomeDestaque
        imgDestaque.image = UIImage(named: data?.imgDestaque ?? "cacto")
        infoDestaque.text = data?.descricaoDestaque
    }

    func setNavigation() {
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    func setUpTable() {
        tableView.dataSource = self
        tableView.delegate   = self
        tableView.register(UINib(nibName: destaquesCell, bundle: nil), forCellReuseIdentifier: destaquesCell)
        tableView.separatorStyle = .none
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            //  data.count
            
            return dataExpDestaques.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let celulaTable = self.tableView.dequeueReusableCell(withIdentifier: destaquesCell, for: indexPath) as? DestaquesTableViewCell
            
            celulaTable?.setUp(model: dataExpDestaques[indexPath.row])
 
            return celulaTable ?? UITableViewCell()
        }
    
    @IBAction func sairBtn(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension DestaquesViewController: DestaquesControllerDelegate {
    func reloadData(data: [DestaquesModel]) {
//        self.data = data
//        DispatchQueue.main.async {
//            self.tableView.reloadData()
//        }
    }
    
    func reloadExp(dataExpDestaques: [ExperienciaDestaquesModel]) {
        DispatchQueue.main.async {
            self.dataExpDestaques.append(ExperienciaDestaquesModel(tituloExp: "Treino em casa", imagemExp: UIImage(named: "treino") ?? UIImage(), descricaoExp: "Faremos alguns exercícios físicos para acabar com o sedentarismo! para iniciantes :)"))
            self.dataExpDestaques.append(ExperienciaDestaquesModel(tituloExp: "Dicas de leitura", imagemExp: UIImage(named: "livro") ?? UIImage(), descricaoExp: "Dicas de livro para você ler em Junho!"))
            self.dataExpDestaques.append(ExperienciaDestaquesModel(tituloExp: "Yoga", imagemExp: UIImage(named: "yoga") ?? UIImage(), descricaoExp: "Uma sessão de Yoga para iniciantes."))
            self.dataExpDestaques.append(ExperienciaDestaquesModel(tituloExp: "Treino em casa", imagemExp: UIImage(named: "treino") ?? UIImage(), descricaoExp: "Faremos alguns exercícios físicos para acabar com o sedentarismo! para iniciantes :)"))
            self.tableView.reloadData()
        }
    }
}

extension DestaquesViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        //Disable bounce only at the top of the screen
        scrollView.bounces = scrollView.contentOffset.y > 100
    }
}

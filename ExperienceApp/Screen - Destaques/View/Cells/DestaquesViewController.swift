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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        lblDestaque.text = data?.nomeDestaque
        imgDestaque.image = data?.image
        infoDestaque.text = data?.descricaoDestaque
        controller.reload(data: data?.experienciasID ?? [])
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
            self.dataExpDestaques = dataExpDestaques
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

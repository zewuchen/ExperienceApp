//
//  DestaquesViewController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class DestaquesViewController: UIViewController, UITableViewDataSource {
    
    // MARK: Outlets
    @IBOutlet weak var lblDestaque: UILabel!
    @IBOutlet weak var imgDestaque: UIImageView!
    @IBOutlet weak var infoDestaque: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: Variáveis
    let destaquesCell = "DestaquesTableViewCell"
    private var data: [DestaquesModel] = []
    private let controller = DestaquesController()
       
     // MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTable()
        setNavigation()
       //  controller.delegate = self
    }
    
    func setUpTable() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: destaquesCell, bundle: nil), forCellReuseIdentifier: destaquesCell)
        tableView.separatorStyle = .none
    }
    
    func setNavigation() {
         self.navigationController?.navigationBar.isTranslucent = true
         self.navigationController?.view.backgroundColor = .clear
     }
    
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            data.count
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let celulaTable = self.tableView.dequeueReusableCell(withIdentifier: destaquesCell, for: indexPath) as? DestaquesTableViewCell
            
            celulaTable?.setUp(model: data[indexPath.row])
        
            return celulaTable ?? UITableViewCell()
        }
}

extension DestaquesViewController: DestaquesControllerDelegate {
    func reloadData(data: [DestaquesModel]) {
        self.data = data
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}

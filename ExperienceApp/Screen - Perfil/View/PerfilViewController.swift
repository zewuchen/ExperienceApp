//
//  PerfilViewController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {
    
    @IBOutlet weak var perfilImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var biographyTitle: UILabel!
    @IBOutlet weak var biographyText: UITextView!
    @IBOutlet weak var experienceTitle: UILabel!
    @IBOutlet weak var experienceTableView: UITableView!
    
    private var data: [ModelExperiencePerfil] = []
    private let controller = PerfilController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self

        experienceTableView.dataSource = self
        experienceTableView.delegate = self
        experienceTableView.register(UINib(nibName: "PerfilExperienciaTableViewCell", bundle: nil), forCellReuseIdentifier: "experiencePerfilCard")
            
        controller.reload()
    }
}

extension PerfilViewController: PerfilControllerDelegate {
    func reloadData(data: [ModelExperiencePerfil]) {
        self.data = data
        self.experienceTableView.reloadData()
    }
}
    
extension PerfilViewController: UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return data.count
           }

           func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
               let cell = tableView.dequeueReusableCell(withIdentifier: "experiencePerfilCard", for: indexPath) as? PerfilExperienciaTableViewCell
               cell?.setUp(model: data[indexPath.row])

               return cell ?? UITableViewCell()
           }
    }

extension PerfilViewController: UITableViewDelegate {
    
}

//
//  GerarViewController.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class GerarViewController: UIViewController {
    
    @IBOutlet weak var txtTema: UITextField!
    @IBOutlet weak var txtDescription: UITextField!
    //Adicionar fotos
    @IBOutlet weak var txtTamanho: UITextField!
    //Adicionar disponibilidade
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnCreateExperience(_ sender: Any) {
        guard let theme = txtTema.text else { return }
        guard let description = txtDescription.text else { return}
        //Add fotos
        guard let size = txtTamanho.text else { return }
        //Add disponibilidade
    }

}

//
//  AdicionarExpPopUpViewController.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 21/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class ExpCriadaPopUp: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func btnConcluído(_ sender: UIButton) {
        let novaTela = PerfilViewController(nibName: "PerfilViewController", bundle: nil)
                 novaTela.modalPresentationStyle = .fullScreen
               self.present(novaTela, animated: true, completion: nil)
           
    }
    
}

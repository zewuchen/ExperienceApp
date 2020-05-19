//
//  LoginViewController.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnLoginScreen(_ sender: Any) {
        let novaTela = CriarContaViewController(nibName: "CriarContaViewController", bundle: nil)
   //       novaTela.modalPresentationStyle = .fullScreen
        self.present(novaTela, animated: true, completion: nil)
    }
    
    @IBAction func btnLoginCreate(_ sender: Any) {
        let novaTela = EntrarNaContaViewController(nibName: "EntrarNaContaViewController", bundle: nil)
        novaTela.modalPresentationStyle = .fullScreen
        self.present(novaTela, animated: true, completion: nil)
    }
    
}

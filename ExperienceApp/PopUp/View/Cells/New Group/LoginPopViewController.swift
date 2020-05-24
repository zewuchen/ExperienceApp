//
//  LoginPopViewController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 24/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class LoginPopViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         let _ = Timer.scheduledTimer(timeInterval: 3.0, target: self, selector: #selector(chamarTela), userInfo: nil, repeats: true)
    }
    
    @objc func chamarTela() {
        let novaTela = MainViewController(nibName: "MainViewController", bundle: nil)
        novaTela.modalPresentationStyle = .fullScreen
        self.present(novaTela, animated: true, completion: nil)
    }
}

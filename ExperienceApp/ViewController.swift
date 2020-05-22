//
//  ViewController.swift
//  ExperienceApp
//
//  Created by Zewu Chen on 14/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func btnNovaTela(_ sender: Any) {
        // MARK: Intruções
        // - Cria uma nova tela a partir do .xib
        // - Faço essa nova tela ficar em fullscreen ao invés de só um modal
        // - Não esquecer de colocar um Restoration ID na View do .xib

        let novaTela = MainViewController(nibName: "MainViewController", bundle: nil)
        novaTela.modalPresentationStyle = .fullScreen
        self.present(novaTela, animated: true, completion: nil)
    }
}

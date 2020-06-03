//
//  HomeViewController.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 21/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func deletarPopUp(_ sender: UIButton) {
        let telaDeDeletar = DeletarExpPopUp()
        telaDeDeletar.modalTransitionStyle  =  .crossDissolve
        telaDeDeletar.modalPresentationStyle = .overCurrentContext
        self.present(telaDeDeletar, animated: true, completion: nil)
    }
    
    @IBAction func adicionadaPopUp(_ sender: Any) {
        let telaDeAdicionada = ExpAdicionadaPopUp()
        telaDeAdicionada.modalTransitionStyle  =  .crossDissolve
        telaDeAdicionada.modalPresentationStyle = .overCurrentContext
        self.present(telaDeAdicionada, animated: true, completion: nil)
    }
    
    @IBAction func criadaPopUp(_ sender: UIButton) {
        let telaDeCriada = ExpCriadaPopUp()
           telaDeCriada.modalTransitionStyle  =  .crossDissolve
           telaDeCriada.modalPresentationStyle = .overCurrentContext
           self.present(telaDeCriada, animated: true, completion: nil)
    }
}

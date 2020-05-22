//
//  HomeViewController.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 21/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, DeletarExpPopUpDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    @IBAction func deletarPopUp(_ sender: UIButton) {
        let vc = DeletarExpPopUp()
        vc.modalTransitionStyle  =  .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func adicionadaPopUp(_ sender: Any) {
        let vc = ExpAdicionadaPopUp()
        vc.modalTransitionStyle  =  .crossDissolve
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func criadaPopUp(_ sender: UIButton) {
        let vc = ExpCriadaPopUp()
           vc.modalTransitionStyle  =  .crossDissolve
           vc.modalPresentationStyle = .overCurrentContext
           self.present(vc, animated: true, completion: nil)
    }
    
    
    
    func handleConfirm() {
        let vc = ProfileViewController()
        self.present(vc, animated: true, completion: nil)
    }
}

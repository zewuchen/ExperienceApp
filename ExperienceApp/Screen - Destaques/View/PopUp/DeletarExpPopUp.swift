//
//  AdicionarPopUpViewController.swift
//  ExperienceApp
//
//  Created by Tamara Erlij on 21/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

protocol DeletarExpPopUpDelegate {
    
func handleConfirm()
   }

class DeletarExpPopUp: UIViewController {
    var delegate: DeletarExpPopUpDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func handleDismissPopup(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
        self.delegate?.handleConfirm()
    }
    
}

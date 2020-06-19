//
//  ExperimentarViewController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 19/06/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class ExperimentarViewController: UIViewController {

    @IBOutlet weak var lblPopUp: UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(chamarTela), userInfo: nil, repeats: true)
    }
    
    @objc func chamarTela() {
        self.dismiss(animated: true, completion: nil)
    }
}

//
//  ExperimentarViewController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 19/06/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class ExperimentarViewController: UIViewController {
    
    @IBOutlet weak var lblTitle: UILabel!
    var titleMessage: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
         let _ = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(chamarTela), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if let lblTitle = lblTitle {
            setLbl(title: titleMessage ?? "Aguarde um momento...")
        }
    }
    
    func setLbl(title: String) {
        lblTitle.text = title
    }
    
    @objc func chamarTela() {
        self.dismiss(animated: true, completion: nil)
    }
}

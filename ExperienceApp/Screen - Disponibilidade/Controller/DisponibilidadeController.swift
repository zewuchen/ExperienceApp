//
//  DisponibilidadeController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import UIKit

class DisponibilidadeController: UIView {
    
    //CLASSE ROUNDED VIEW NA VDD
    
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
}

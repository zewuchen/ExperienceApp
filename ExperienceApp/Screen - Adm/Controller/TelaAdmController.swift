//
//  TelaAdmController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 25/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

protocol TelaAdmControllerDelegate: AnyObject {
    func reloadData(data: [DestaquesModel])
    func setImageProfile()
}

final class TelaAdmController {
    private var data: [DestaquesModel] = []
    weak public var delegate: TelaAdmControllerDelegate?
    
    public init() {
        //self.append
    }
    
    public func setImage() {
        delegate?.setImageProfile()
    }
}

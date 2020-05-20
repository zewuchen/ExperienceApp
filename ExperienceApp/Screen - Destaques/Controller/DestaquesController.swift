//
//  File.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation

protocol DestaquesControllerDelegate: AnyObject {
    func reloadData(data: [DestaquesModel])
}

final class DestaquesController {
    private var data: [DestaquesModel] = []
    
    weak public var delegate: DestaquesControllerDelegate?
    
    
}

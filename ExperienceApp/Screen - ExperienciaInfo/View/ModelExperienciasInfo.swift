//
//  ModelExperienciasInfo.swift
//  ExperienceApp
//
//  Created by Nathalia Melare on 20/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import Foundation
import UIKit

class ModelExperienciasInfo {
    var infoImage = UIImage()
    var titleExp = String()
//    var rating = Int()
    var durationTime = Int()
    var howManyPeople = Int()
    var descriptionExp = String()
    var tags = [String]()
    var hostImage = UIImage()
    var hostName = String()
    var hostDescription = String()
    var howParticipate = String()
    var whatYouNeedDescription = String()
    var recordName = String()
    
    init(infoImage: UIImage, titleExp: String, durationTime: Int, howManyPeople: Int, tags: [String], descriptionExp: String,
         hostImage:UIImage, hostName: String, hostDescription: String, howParticipate: String, whatYouNeedDescription: String, recordName: String) {
        self.infoImage = infoImage
        self.titleExp = titleExp
        self.durationTime = durationTime
        self.howManyPeople = howManyPeople
        self.tags = tags
        self.descriptionExp = descriptionExp
        self.hostImage = hostImage
        self.hostName = hostName
        self.hostDescription = hostDescription
        self.howParticipate = howParticipate
        self.whatYouNeedDescription = whatYouNeedDescription
        self.recordName = recordName
    }
}

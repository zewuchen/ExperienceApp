//
//  PerfilExperienciaTableViewCell.swift
//  ExperienceApp
//
//  Created by Nathalia Melare on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class PerfilExperienciaTableViewCell: UITableViewCell {

    @IBOutlet weak var titleCard: UILabel!
    @IBOutlet weak var imageCard: UIImageView!
    @IBOutlet weak var dataCard: UILabel!
    @IBOutlet weak var linkCard: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 10
        self.imageCard.layer.cornerRadius = 10
        self.titleCard.font = .AvenirHeavy20
        self.dataCard.font = .AvenirRoman
        self.linkCard.font = .AvenirRoman
        
    }
    
    func setUp(model: ModelExperiencePerfil) {
        self.titleCard.text = model.titulo
        self.imageCard.image = model.imagem
        self.dataCard.text = model.data
        self.linkCard.text = model.link
   
    }
}

//
//  DestaquesTableViewCell.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class DestaquesTableViewCell: UITableViewCell {

    @IBOutlet weak var titleCard: UILabel!
    @IBOutlet weak var subtitleCard: UILabel!
    @IBOutlet weak var imgCard: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setUp(model: ExperienciaDestaquesModel) {
        self.titleCard?.text = model.tituloExp
        self.subtitleCard.text = model.descricaoExp
        self.imgCard.image = model.imagemExp
    }
    
    func setUpCriarDestaques(model: DestaquesModel) {
        self.titleCard.text = model.nomeDestaque
        self.imgCard.image = UIImage(named: model.imgDestaque)
        self.subtitleCard.text = model.descricaoDestaque
    }
}

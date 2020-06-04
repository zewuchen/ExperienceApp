//
//  RecomendacoesTableViewCell.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class RecomendacoesTableViewCell: UITableViewCell {

    @IBOutlet weak var imageCard: UIImageView!
    @IBOutlet weak var titleCard: UILabel?
    @IBOutlet weak var subtitleCard: UILabel!
    @IBOutlet weak var iconRating: UIImageView!
    @IBOutlet weak var lbRating: UILabel?
    @IBOutlet weak var costValue: UILabel?
    var recordName = ""
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleCard?.font = .AvenirHeavy
        subtitleCard.font = .AvenirRoman
        lbRating?.font = .AvenirRoman
        costValue?.font = .AvenirRoman
        price.font = .AvenirRoman
        price.textColor = .roxoTijolo
        imageCard.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(model: MainModel) {
        self.lbRating?.text = String(model.notaExp)
        self.costValue?.text = model.precoExp
        self.titleCard?.text = model.nomeExp
        self.imageCard.image = UIImage(named: "cacto")
    
        if let imagem = model.image {
            self.imageCard.image = UIImage(data: imagem)
        }

        if model.isSelected {
            self.titleCard?.textColor = .vermelhoTijolo
        } else {
            self.titleCard?.textColor = .black
        }
        
        self.recordName = model.recordName
    }
}

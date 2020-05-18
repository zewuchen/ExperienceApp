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
    @IBOutlet weak var titleCard: UILabel!
    @IBOutlet weak var subtitleCard: UILabel!
    @IBOutlet weak var iconRating: UIImageView!
    @IBOutlet weak var lbRating: UILabel!
    @IBOutlet weak var costValue: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

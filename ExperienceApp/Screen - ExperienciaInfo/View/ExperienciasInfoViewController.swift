//
//  ExperienciasInfoViewController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class ExperienciasInfoViewController: UIViewController {
    
    @IBOutlet weak var infoImage: UIImageView!
    @IBOutlet weak var imagePageControl: UIPageControl!
    @IBOutlet weak var infoScrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var starIconImage: UIImageView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var reviewButton: UIButton!
    @IBOutlet weak var timeIconImage: UIImageView!
    @IBOutlet weak var titleTimeLabel: UILabel!
    @IBOutlet weak var groupIconImage: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var peopleFixedLabel: UILabel!
    @IBOutlet weak var hoursFixedLabel: UILabel!
    @IBOutlet weak var titleGroupLabel: UILabel!
    @IBOutlet weak var peopleQuantLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var tagsStackView: UIStackView!
    @IBOutlet weak var tagLabel1: UILabel!
    @IBOutlet weak var tagLabel2: UILabel!
    @IBOutlet weak var tagLabel3: UILabel!
    @IBOutlet weak var tagLabel4: UILabel!
    @IBOutlet weak var titlehostLabel: UILabel!
    @IBOutlet weak var hostImage: UIImageView!
    @IBOutlet weak var hostNameLabel: UILabel!
    @IBOutlet weak var descriptionHostLabel: UILabel!
    @IBOutlet weak var titleHowPartLabel: UILabel!
    @IBOutlet weak var descriptionHowPartLabel: UILabel!
    @IBOutlet weak var whatDoINeedTitleLabel: UILabel!
    @IBOutlet weak var whatDoINeedDescriptionLabel: UILabel!
    @IBOutlet weak var backgroundtExpImage: UIImageView!
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var experienceButton: UIButton!
    
    private let controller = ExperienciasInfoController()
//    private var data: [ModelExperienciasInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.delegate = self
        
        self.view.backgroundColor = .background
        self.infoView.backgroundColor = .background
        self.infoScrollView.backgroundColor = .background
        
        setupHeaderDescription()
        setupHost()
        setupHowParticipate()
        setupExperienceButton()
        setupWhatDoINeed()
        tags()
        
        controller.reload()
    }
    
    func setupHeaderDescription() {
        titleLabel.font = .RockwellBold24
        scoreLabel.font = .AvenirRoman
        reviewButton.titleLabel?.font = .AvenirRoman
        titleTimeLabel.font = .AvenirRoman
        timeLabel.font = .AvenirRoman
        hoursFixedLabel.font = .AvenirRoman
        peopleFixedLabel.font = .AvenirRoman
        titleGroupLabel.font = .AvenirRoman
        peopleQuantLabel.font = .AvenirRoman
        descriptionLabel.font = .AvenirRoman
    }
    
    func setupHost() {
        titlehostLabel.font = .RockwellBold20
        hostNameLabel.font = .AvenirHeavy
        descriptionHostLabel.font = .AvenirRoman
        hostImage.layer.cornerRadius = self.hostImage.frame.size.height/2
        
    }
    
    func setupHowParticipate() {
        titleHowPartLabel.font = .RockwellBold20
        descriptionHowPartLabel.font = .AvenirRoman
        valueLabel.font = .Rockwell24
    }
    
    func setupWhatDoINeed() {
        whatDoINeedTitleLabel.font = .RockwellBold20
        whatDoINeedDescriptionLabel.font = .AvenirRoman
        whatDoINeedTitleLabel.text = "O que preciso?"
    }
    
    func setupExperienceButton() {
        experienceButton.backgroundColor = .vermelhoTijolo
        experienceButton.titleLabel?.font = .RockwellBold20
        experienceButton.layer.cornerRadius = 20
        experienceButton.titleLabel?.textColor = .white
        experienceButton.layer.zPosition = 1
    }
    
    func tags() {
        if tagLabel1.text == "Label" {
            tagsStackView.removeFromSuperview()
            titlehostLabel
        }
    }
}

extension ExperienciasInfoViewController: ExperienciasInfoControllerDelegate {
    
    func reloadData(data: ModelExperienciasInfo) {
//        self.data = data
        self.infoImage.image = data.infoImage
        self.titleLabel.text = data.titleExp
        self.timeLabel.text = String(data.durationTime)
        self.peopleQuantLabel.text = String(data.howManyPeople)
        self.descriptionLabel.text = data.descriptionExp
        self.hostNameLabel.text = data.hostName
        self.hostImage.image = data.hostImage
        self.descriptionHostLabel.text = data.hostDescription
        self.descriptionHowPartLabel.text = data.howParticipate
        self.whatDoINeedDescriptionLabel.text = data.whatYouNeedDescription
        
    }
}

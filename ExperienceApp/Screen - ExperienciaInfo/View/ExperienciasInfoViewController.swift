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
    @IBAction func reviewButton(_ sender: Any) {
        
    }
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
    @IBOutlet weak var exitButton: UIButton!
    @IBAction func exitButton(_
        sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    var recordName: String = ""
    var botao = true
    
    public var controller = ExperienciasInfoController()
//    private var data: [ModelExperienciasInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        controller.delegate = self
        
        self.view.backgroundColor = .background
        self.infoView.backgroundColor = .background
        self.infoScrollView.backgroundColor = .background
        
        switch tagLabel1.text == "Label" {
        case true:
            tagsStackView.removeFromSuperview()
            titlehostLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20).isActive = true
        default:
            titlehostLabel.topAnchor.constraint(equalTo: tagsStackView.bottomAnchor, constant: 20).isActive = true
        }
        
//        Remove "h" de horas na data, mudar text se voltar a "Duraçāo" e remove page control da image
        self.hoursFixedLabel.text = ""
        self.imagePageControl.removeFromSuperview()
        
        switch scoreLabel.text == "" {
        case true:
            scoreLabel.removeFromSuperview()
            starIconImage.removeFromSuperview()
            reviewButton.removeFromSuperview()
            titleTimeLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
            titleGroupLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        default:
            scoreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
            starIconImage.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
            reviewButton.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive = true
        }
        
        descriptionLabel.topAnchor.constraint(equalTo: timeIconImage.bottomAnchor, constant: 25).isActive = true
        hostImage.topAnchor.constraint(equalTo: titlehostLabel.bottomAnchor, constant: 20).isActive = true
         hostNameLabel.topAnchor.constraint(equalTo: titlehostLabel.bottomAnchor, constant: 20).isActive = true
         descriptionHostLabel.topAnchor.constraint(equalTo: titlehostLabel.bottomAnchor, constant: 30).isActive = true
         titleHowPartLabel.topAnchor.constraint(equalTo: descriptionHostLabel.bottomAnchor, constant: 20).isActive = true
         descriptionHowPartLabel.topAnchor.constraint(equalTo: titleHowPartLabel.bottomAnchor, constant: 15).isActive = true
         whatDoINeedTitleLabel.topAnchor.constraint(equalTo: descriptionHowPartLabel.bottomAnchor, constant: 20).isActive = true
         whatDoINeedDescriptionLabel.topAnchor.constraint(equalTo: whatDoINeedTitleLabel.bottomAnchor, constant: 10).isActive = true
        
        navigationController?.navigationBar.isHidden = true

        setupHeaderDescription()
        setupHost()
        setupHowParticipate()
        setupExperienceButton()
        setupWhatDoINeed()
        setupTags()
        setupReviewButton()
        
        controller.reload()
    }

    override func viewWillAppear(_ animated: Bool) {
        let _ = setUserHasExperience()
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
        experienceButton.titleLabel?.textAlignment = .center
    }
    
    func setupReviewButton() {
        reviewButton.titleLabel?.textColor = .vermelhoTijolo
        reviewButton.titleLabel?.text = "(Review)"
        reviewButton.titleLabel?.font = .AvenirHeavy
    }
    
    func setupTags() {
        tagLabel1.font = .AvenirHeavy
        tagLabel2.font = .AvenirHeavy
        tagLabel3.font = .AvenirHeavy
        tagLabel4.font = .AvenirHeavy
    }

    @IBAction func btnExperimentar(_ sender: Any) {
        setReserva(disponivel: !botao)
        botao = !botao
    }

    func setUserHasExperience() -> Bool {
        if var marcadas = UserDefaults.standard.stringArray(forKey: "marcadas") {
            if !marcadas.isEmpty {
                for record in 0...marcadas.count-1 {
                    if marcadas[record] == recordName {
                        setReserva(disponivel: false)
                        return true
                    }
                }
            }
        }
        return false
    }

    // FIXME: Problema ao alterar o título da label quando clicada, o background vai normal
    func setReserva(disponivel: Bool) {
        if disponivel {
            DispatchQueue.main.async {
                self.experienceButton.titleLabel?.text = "Experimentar"
                self.experienceButton.backgroundColor = .vermelhoTijolo
            }
        } else {
            DispatchQueue.main.async {
                self.experienceButton.titleLabel?.text = "Reservado"
                self.experienceButton.backgroundColor = .black
            }
        }
    }

}

extension ExperienciasInfoViewController: ExperienciasInfoControllerDelegate {
    func reloadData(data: ModelExperienciasInfo, responsible: UserResponsavel?) {
//        self.data = data
        DispatchQueue.main.async {
            self.recordName = data.recordName
            self.infoImage.image = data.infoImage
            self.titleLabel.text = data.titleExp
            self.timeLabel.text = String(data.durationTime)
            self.peopleQuantLabel.text = String(data.howManyPeople)
            self.descriptionLabel.text = data.descriptionExp
            self.hostNameLabel.text = data.hostName
//            self.hostImage.image = data.hostImage
            self.descriptionHostLabel.text = data.hostDescription
            self.descriptionHowPartLabel.text = data.howParticipate
            self.whatDoINeedDescriptionLabel.text = data.whatYouNeedDescription
            self.timeLabel.text = data.data
            self.hostImage.image = UIImage(named: "userDefault") ?? UIImage()
            self.hostNameLabel.text = "User"
            self.descriptionHostLabel.text = "Amante de experiências"

            // Desabilita o botão caso tenha todas as vagas preenchidas
            if !data.available && !self.setUserHasExperience() {
                self.experienceButton.isEnabled = false
                self.experienceButton.isHidden = true
            }
        }
//        self.tagLabel1.text = data.tags[0]
        if let responsible = responsible {
            DispatchQueue.main.async {
                self.hostImage.image = UIImage(data: responsible.image)
                self.hostNameLabel.text = responsible.name
                self.descriptionHostLabel.text = responsible.description
            }
        }
    }
}

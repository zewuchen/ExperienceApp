//
//  PerfilViewController.swift
//  ExperienceApp
//
//  Created by Juliana Vigato Pavan on 15/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import UIKit

class PerfilViewController: UIViewController {
    
    @IBOutlet weak var perfilScrollView: UIScrollView!
    @IBOutlet weak var perfilView: UIView!
    @IBOutlet weak var perfilImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var biographyTitle: UILabel!
    @IBOutlet weak var biographyText: UITextView!
    @IBOutlet weak var experienceTitle: UILabel!
    @IBOutlet weak var experienceTableView: UITableView!
    @IBOutlet weak var createExperienceButton: UIButton!
    
    private var data: [ModelExperiencePerfil] = []
    private let controller = PerfilController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        controller.delegate = self
        
        setUpImage()
        setUpButton()
        setUpBiography()
        setUpUserData()
        setUpBackground()
                
        experienceTableView.dataSource = self
        experienceTableView.delegate = self
        experienceTableView.register(UINib(nibName: "PerfilExperienciaTableViewCell", bundle: nil), forCellReuseIdentifier: "experiencePerfilCard")
        
        navigationController?.navigationBar.isHidden = true
            
        controller.reload()
        controller.setUpProfileData()
    }
    
    @IBAction func sairBtn(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }
    
    func setUpImage() {
        perfilImage.image = UIImage(named: "userDefault")!
        if let nameImage = UserDefaults.standard.string(forKey: "image"), UserDefaults.standard.bool(forKey: "logged") {
            if let imagePath = FileHelper.getFile(filePathWithoutExtension: nameImage) {
                let image = UIImage(contentsOfFile: imagePath)
                self.perfilImage.image = image
            }
        }
        perfilImage.layer.cornerRadius = 10
    }
    
    func setUpButton() {
        createExperienceButton.backgroundColor = .vermelhoTijolo
        createExperienceButton.titleLabel?.font = .RockwellBold20
        createExperienceButton.layer.cornerRadius = 10
        createExperienceButton.titleLabel?.textColor = .white
        createExperienceButton.titleLabel?.textAlignment = .center
    }
    
    func setUpBiography() {
        biographyText.layer.cornerRadius = 10
        biographyText.allowsEditingTextAttributes = false
    }
    
    func setUpUserData() {
        name.font = .Rockwell20
        biographyTitle.font = .Rockwell24
        biographyText.font = .AvenirRoman
        experienceTitle.font = .Rockwell24
    }
    
    func setUpBackground() {
        self.view.backgroundColor = .background
        self.experienceTableView.backgroundColor = .background
        self.perfilView.backgroundColor = .background
        self.perfilScrollView.backgroundColor = .background
    }

    @IBAction func btnLogoff(_ sender: Any) {
        controller.logoff()
    }

    @IBAction func btnNewExperience(_ sender: Any) {
        let novaTela = GerarViewController(nibName: "GerarViewController", bundle: nil)
        self.present(novaTela, animated: true, completion: nil)
    }
    
}

extension PerfilViewController: PerfilControllerDelegate {
    func logoff() {
        self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

    func reloadProfileData(data: AuthModel) {
        self.name.text = data.name
        self.biographyText.text = data.description
        if let imagem = UIImage(contentsOfFile: FileHelper.getFile(filePathWithoutExtension: data.image) ?? "") {
            self.perfilImage.image = imagem
        }
    }

    func reloadData(data: [ModelExperiencePerfil]) {
        DispatchQueue.main.async {
            self.data = data
            self.experienceTableView.reloadData()
        }
    }
}
    
extension PerfilViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
               return 1
           }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "experiencePerfilCard", for: indexPath) as? PerfilExperienciaTableViewCell
        cell?.setUp(model: data[indexPath.section])

        return cell ?? UITableViewCell()
    }
}

extension PerfilViewController: UITableViewDelegate {
    
}

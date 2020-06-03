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
    func reloadData(data: [MainModel])
    func setImageProfile()
}

final class TelaAdmController {
    private var data: [MainModel] = []
    weak public var delegate: TelaAdmControllerDelegate?
    
    public init() {
        let _ = Timer.scheduledTimer(timeInterval: 300.0, target: self, selector: #selector(getDataCloud), userInfo: nil, repeats: true)
    }
    
    @objc func getDataCloud() {
        reload()
    }
    
    public func reload() {
        self.data = []
        Cloud.shared.getExperience(data: nil) { (records, error) in
            for record in records {
                guard let name = record?["title"] else { return }
                guard let description = record?["description"] else { return }
                guard let comoParticipar = record?["howToParticipate"] else { return }
                guard let tamanho = record?["lengthGroup"] else { return }
                guard let recursos = record?["whatToTake"] else { return }
                guard let recordName = record?.recordID.recordName else { return }
                guard let responsible = record?["responsible"] else { return }
                guard let pessoa = responsible as? CKRecord.Reference else { return }
                guard let data = record?["date"] else { return }
                guard let dataExperiencia = data as? Date else { return }
                let formatarData = DateFormatter()
                formatarData.dateFormat = "dd/MM/yyyy"
                
                if let image = record?["image"] {
                    guard let file: CKAsset? = image as? CKAsset else { return }
                    if let file = file {
                        if let dado = NSData(contentsOf: file.fileURL!) {
                            self.data.append(MainModel(nomeDestaque: "", nomeExp: name.description, descricaoExp: description.description, notaExp: 10.0, precoExp: description.description, recordName: record?.recordID.recordName ?? ""
                                , image: dado as Data, recursos: recursos.description, comoParticipar: comoParticipar.description, tamanho: Int(tamanho.description), responsible: pessoa.recordID.recordName, data: formatarData.string(from: dataExperiencia)))
                        }
                    }
                } else {
                    self.data.append(MainModel(nomeDestaque: "", nomeExp: name.description, descricaoExp: description.description, notaExp: 10.0, precoExp: "Gratuito", recordName: record?.recordID.recordName ?? "", image: Data()
                        , recursos: recursos.description, comoParticipar: comoParticipar.description, tamanho: Int(tamanho.description), responsible: pessoa.recordID.recordName, data: ""))
                }
            }
            self.delegate?.reloadData(data: self.data)
        }
    }
    
    public func setImage() {
        delegate?.setImageProfile()
    }
    
    func salvarFoto(imagem:UIImage) -> String {
        let fileName = UUID().uuidString
        FileHelper.saveImage(image: imagem, nameWithoutExtension: fileName)
        return fileName
    }
    
    func deleteFoto(fileURL: String?) {
        guard let fileURL = fileURL else { return }
        FileHelper.deleteImage(filePathWithoutExtension: fileURL)
    }

    public func createHighlight(data: HighlightModel) {
        Cloud.shared.createHighlight(data: data)
    }
}

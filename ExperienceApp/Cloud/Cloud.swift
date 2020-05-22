//
//  Cloud.swift
//  ExperienceApp
//
//  Created by Zewu Chen on 18/05/20.
//  Copyright © 2020 Zewu Chen. All rights reserved.
//

import CloudKit
import CryptoKit
import UIKit

enum Record {
    case login

    var record: String {
        switch self {
        case .login: return "User"
        }
    }
}

struct AuthModel {
    let name: String?
    let description: String?
    let email: String
    let password: String
    let image: String
}

struct ExperienceModel {
    // Data
    let title: String
    let description: String
    let recordName: String?
//    let date: Date // Formato: YYYY-MM-DD HH:mm:ss
//    let duration: Double
    let howToParticipate: String
    let lengthGroup: Int64
//    let price: Double
    let whatToTake: String
//    let availableVacancies: Int64
    // Essa parte é feita no backend
//    let score: Double?
//    let image: ??
//    let participants: [AuthModel]
//    let comments: [AuthModel]
//    let tags: [String]
}

final class Cloud {

    let container: CKContainer
    let publicDB: CKDatabase
    let privateDB: CKDatabase
    let sharedDB: CKDatabase
    var predicate: NSPredicate
    var url: URL

    private init() {
        self.container = CKContainer(identifier: "iCloud.ExperienceApp")
        self.publicDB = container.publicCloudDatabase
        self.privateDB = container.privateCloudDatabase
        self.sharedDB = container.sharedCloudDatabase
        self.predicate = NSPredicate(value: true)
        self.url = URL(fileURLWithPath: "")
    }

    static let shared = Cloud()

    // MARK: Auth
    public func createUser(data: AuthModel) {
        let user = CKRecord(recordType: "User")

        user.setValue(data.name, forKey: "name")
        user.setValue(data.description, forKey: "description")
        user.setValue(data.email, forKey: "email")
        user.setValue(encryptPassword(password: data.password), forKey: "password")

        self.url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(NSUUID().uuidString+".dat") ?? URL(string: "")!

        if data.image != "" {
            guard let image = UIImage(contentsOfFile: FileHelper.getFile(filePathWithoutExtension: data.image) ?? "") else { return }
            guard let dataImage = image.jpegData(compressionQuality: 0) else { return }
            do {
                try dataImage.write(to: url)
            } catch let erro as NSError {
                print("Error! \(erro)")
                return
            }
            user.setValue(CKAsset(fileURL: url), forKey: "image")
        }

        authUser(data: data) { (record, error) in
            if let record = record {
                // TODO: Tratar erro para quando já tiver o usuário logado
                print("Usuário já registrado")
            } else {
                // FIXME: (Primeira vez que cadastra, ele buga)
                self.cloudSave(record: user, database: self.publicDB)
            }
        }
    }

    private func cloudSave(record: CKRecord, database: CKDatabase) {
        self.publicDB.save(record) { (record, error) in
            if let error = error {
                // TODO: Tratar o erro quando salva o usuário
                print("Erro ao salvar")
            } else {
                print("Salvo com Sucesso")
            }
            do {
                try FileManager.default.removeItem(at: self.url)
                print("Temp file deletado com sucesso")
            } catch let erro {
                print("Error deleting temp file: \(erro)")
            }
        }
    }

    public func encryptPassword(password: String) -> String {
        guard let keyChain = Bundle.main.object(forInfoDictionaryKey: "ChaveAcesso") else { return "" }
        var password = password
        if let aux = keyChain as? String {
            password += aux
        }
        let senha = password.data(using: .utf8)!
        let hash = SHA256.hash(data: senha)

        return hash.map { String(format: "%02hhx", $0) }.joined()
    }

    public func authUser(data: AuthModel, completionHandler: @escaping (CKRecord?, Error?) -> Void) {
        self.predicate = NSPredicate(format: "email == '\(data.email)' AND password == '\(encryptPassword(password: data.password))'")
        let query = CKQuery(recordType: "User", predicate: predicate)

        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let records = records {
                print(records)
                completionHandler(records.first, error)
            } else {
                completionHandler(nil, error)
            }
        }
    }

    // MARK: Experience
    public func getUser(data: AuthModel, completionHandler: @escaping (CKRecord?, Error?) -> Void) {
        self.predicate = NSPredicate(format: "email == '\(data.email)' AND password == '\(data.password)'")
        let query = CKQuery(recordType: "User", predicate: predicate)

        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let records = records {
                completionHandler(records.first, error)
            } else {
                completionHandler(nil, error)
            }
        }
    }

    public func getExperience(data: ExperienceModel?, completionHandler: @escaping ([CKRecord?], Error?) -> Void) {
        var query = CKQuery(recordType: "Experience", predicate: NSPredicate(value: true))

        if let data = data {
            guard let search = data.recordName else { return }
//            self.predicate = NSPredicate(format: "title == '\(reference)'")
            self.predicate = NSPredicate(format: "recordID = %@", CKRecord.ID(recordName: search))
            query = CKQuery(recordType: "Experience", predicate: predicate)
        }

        publicDB.perform(query, inZoneWith: nil) { (records, error) in
            if let records = records {
                completionHandler(records, error)
            } else {
                completionHandler([], error)
            }
        }
    }

    public func createExperience(data: ExperienceModel) {
        guard let name = UserDefaults.standard.string(forKey: "name") else { return }
        guard let description = UserDefaults.standard.string(forKey: "description") else { return }
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }
        guard let password = UserDefaults.standard.string(forKey: "password") else { return }

        let user = AuthModel(name: name, description: description, email: email, password: password, image: "")

        getUser(data: user) { (record, error) in

            if let record = record {
                let experience = CKRecord(recordType: "Experience")

                experience.setValue(data.title, forKey: "title")
                experience.setValue(data.whatToTake, forKey: "whatToTake")
                experience.setValue(data.lengthGroup, forKey: "lengthGroup")
                experience.setValue(data.howToParticipate, forKey: "howToParticipate")
                experience.setValue(data.description, forKey: "description")
//                experience.setValue(data.duration, forKey: "duration")
//                experience.setValue(data.availableVacancies, forKey: "availableVacancies")
//                experience.setValue(data.price, forKey: "price")
                // TODO: Pensar se o usuário excluir sua conta, suas experiências também serão excluídas
                experience.setValue(CKRecord.Reference(recordID: record.recordID, action: .none), forKey: "responsible")
//                experience.setValue(data.score, forKey: "score")

                self.cloudSave(record: experience, database: self.publicDB)
            }
        }
    }

    // MARK: User
    public func attachExperience(data: ExperienceModel) {
        guard let name = UserDefaults.standard.string(forKey: "name") else { return }
        guard let description = UserDefaults.standard.string(forKey: "description") else { return }
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }
        guard let password = UserDefaults.standard.string(forKey: "password") else { return }

        let user = AuthModel(name: name, description: description, email: email, password: password, image: "")

        getUser(data: user) { (usuario, error) in
            guard let usuario = usuario else { return }
            let assetsOld = usuario["experiences"] as? [CKRecord.Reference]

            var experiencesRecords = [CKRecord.Reference]()

            if let assetsOld = assetsOld {
                for asset in assetsOld {
                    experiencesRecords.append(asset)
                }
            }
            self.getExperience(data: data) { (experiences, errors) in
                for experience in experiences {
                    if let record = experience {
                        let reference = CKRecord.Reference(record: record, action: .none)
                        experiencesRecords.append(reference)

                        // TODO: Adicionar usuário na referência de participantes da Experiência
                    }
                }
                usuario.setObject(experiencesRecords as CKRecordValue, forKey: "experiences")
                self.cloudSave(record: usuario, database: self.publicDB)
            }
        }
    }

    public func desattachExperience(data: ExperienceModel) {
        guard let name = UserDefaults.standard.string(forKey: "name") else { return }
        guard let description = UserDefaults.standard.string(forKey: "description") else { return }
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }
        guard let password = UserDefaults.standard.string(forKey: "password") else { return }

        let user = AuthModel(name: name, description: description, email: email, password: password, image: "")

        getUser(data: user) { (usuario, error) in
            guard let usuario = usuario else { return }
            let assetsOld = usuario["experiences"] as? [CKRecord.Reference]

            var experiencesRecords = [CKRecord.Reference]()

            if let assetsOld = assetsOld {
                for asset in assetsOld {
                    guard let recordName = data.recordName else { return }
                    if asset.recordID.recordName != recordName {
                        experiencesRecords.append(asset)
                    }
                }
            }
            usuario.setObject(experiencesRecords as CKRecordValue, forKey: "experiences")
            self.cloudSave(record: usuario, database: self.publicDB)
        }
    }

    public func getMyExperiences(completionHandler: @escaping ([CKRecord?], Error?) -> Void) {
        guard let email = UserDefaults.standard.string(forKey: "email") else { return }
        guard let password = UserDefaults.standard.string(forKey: "password") else { return }

        let user = AuthModel(name: "", description: "", email: email, password: password, image: "")

        getUser(data: user) { (usuario, error) in
            guard let usuario = usuario else { return }
            if let experiences = usuario["experiences"] as? [CKRecord.Reference] {
                var recordsIDs = [CKRecord.ID]()
                for experience in experiences {
                    recordsIDs.append(experience.recordID)
                }
                var fetchOperation = CKFetchRecordsOperation(recordIDs: recordsIDs)
                fetchOperation.fetchRecordsCompletionBlock = {
                    recordData, erros in

                    var data = [CKRecord]()

                    if let recordData = recordData {
//                        recordData.enumerated() // Devolve um vetor com todas as coisas
//                        recordData.map {(chave, valor) -> Void in
//                            data.append(valor)
//                        } // Transformar um conjunto de dados num outro
                        for(key, value) in recordData {
                            data.append(value)
                        }
                        completionHandler(data, erros)
                    } else {
                        completionHandler([], erros)
                    }
                }
                self.container.publicCloudDatabase.add(fetchOperation)
            }
        }
    }

    public func teste() {}
}

//
//  CarModel.swift
//  Cars
//
//  Created by PhyoMyanmarKyaw on 23/03/2022.
//

import Foundation
import RealmSwift

// MARK: - Model
struct CarPlainModel {
    var id = Int()
    var title = String()
    var desc = String()
    var imageUrl = String()
    
    func toRealmModel() -> CarEntity {
        let realmModel = CarEntity()
        realmModel.id = self.id
        realmModel.title = self.title
        realmModel.desc = self.desc
        realmModel.imageUrl = self.imageUrl
        return realmModel
    }
    
}

struct CarModel: Decodable {
    let id: Int
    let title: String
    let desc: String
    let imageUrl: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case title = "pokemon"
        case desc = "location"
        case imageUrl = "image_url"
    }
    
    func toPlainModel() -> CarPlainModel {
        return CarPlainModel(id: id, title: title, desc: desc, imageUrl: imageUrl)
    }
}

// MARK: - Realm Entity
class CarEntity: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var title: String = ""
    @objc dynamic var desc: String = ""
    @objc dynamic var imageUrl: String = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    func toPlainModel() -> CarPlainModel {
        return CarPlainModel(id: id, title: title, desc: desc, imageUrl: imageUrl)
    }
}

//
//  RealmHelper.swift
//  Cars
//
//  Created by PhyoMyanmarKyaw on 24/03/2022.
//

import Foundation
import RealmSwift

class RealmHelper {
    
    // MARK: - Singleton
    static let shared = RealmHelper()
    
    let realm = try! Realm()
    
    private init(){}
    
    // MARK: - SAVE
    func save(carPlainModel: [CarPlainModel]) {
        try! realm.write {
            for model in carPlainModel {
                let realmModel = model.toRealmModel()
                if realm.object(ofType: CarEntity.self,
                         forPrimaryKey: realmModel.id) == nil {
                    realm.add(realmModel)
                }
                else {
                    realm.add(realmModel, update: .modified)
                }
            }
        }
    }
    
    // MARK: - LOAD
    func load() -> [CarPlainModel] {
         return realm.objects(CarEntity.self).map{ $0.toPlainModel() }
    }
    
    // MARK: - REMOVE
    func remove(id: String) {
        let car = realm.object(ofType: CarEntity.self, forPrimaryKey: id)
        do {
            try realm.write {
                realm.delete(car!)
            }
        } catch {
            print("DeleteFromPersistenceError:- \(error.localizedDescription)")
        }
    }
}

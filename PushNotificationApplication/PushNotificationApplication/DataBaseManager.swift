//
//  DataBaseManager.swift
//  PushNotificationApplication
//
//  Created by Александр Арсенюк on 23/03/2019.
//  Copyright © 2019 Александр Арсенюк. All rights reserved.
//

import Foundation
import RealmSwift

protocol DataBaseManagerProtocol {
    
    /// получить массив объектов из бд
    ///
    /// - Returns: массив объектов типа Notification
    func obtainModels() -> [NotificationObject]
    
    /// сохраняет объект типа Notification
    ///
    /// - Parameter model: объект
    func save(model: NotificationObject)
    
    /// очистить бд
    func clearAll()
    
}

class DataBaseManager: DataBaseManagerProtocol {
    
    fileprivate lazy var mainRealm: Realm = {
        
        let config = Realm.Configuration(
            
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                if (oldSchemaVersion < 1) {
                    
                }
        })
        Realm.Configuration.defaultConfiguration = config
        return try! Realm(configuration: .defaultConfiguration)
    }()
    
    func obtainModels() -> [NotificationObject] {
        
        let models = mainRealm.objects(NotificationObject.self)
        return Array(models)
    }
    
    func save(model: NotificationObject) {
        
        try! mainRealm.write {
            mainRealm.add(model)
        }
    }
    
    func clearAll() {
        
        try! mainRealm.write {
            mainRealm.deleteAll()
        }
    }
}

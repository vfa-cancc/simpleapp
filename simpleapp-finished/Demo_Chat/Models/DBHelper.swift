//
//  DBHelper.swift
//  HuCaChat
//
//  Created by HungNV on 6/14/20.
//  Copyright © 2020 HungNV. All rights reserved.
//

import Foundation
import RealmSwift

class DBHelper {
    static let share = DBHelper()
    private var database: Realm!
    
    init() {
        do {
            database = try Realm.init()
            print("Realm is located at:", database.configuration.fileURL!)
        } catch let e {
            print(e.localizedDescription)
        }
    }
    
    func getDataFromRealm<T: Object>(type: T.Type) -> [T]{
        let objects = database.objects(type)
        return objects.toArray()
    }

    func removeAllRealm() {
        try! database.write {
            database.deleteAll()
        }
    }

    func removeAllObject<T: Object>(type: T.Type){
        try! database.write {
            let allObject = database.objects(type)
            database.delete(allObject)
        }
    }

    func removeAllObject<T: Object, V: Codable>(type: T.Type, key: String, value: V) {
        try! database.write {
            var query = "\(key) contains '\(value)'"
            if value is Int {
                query = "\(key) = \(value)"
            }
            let objects = database.objects(type).filter(query)
            if objects.count > 0 {
                database.delete(objects)
            }
        }
    }
    
    func removeObject<T: Object>(type: T.Type, id: Any) {
        let objectTemp = self.database.object(ofType: type, forPrimaryKey: id)
        if objectTemp != nil {
            try! self.database.write {
                self.database.delete(objectTemp!)
            }
        }
    }

    func removeObject<T: Object, V: Codable>(type: T.Type, value: V) {
        let objectTemp = self.database.object(ofType: type, forPrimaryKey: value)
        if objectTemp != nil {
            try! self.database.write {
                self.database.delete(objectTemp!)
            }
        }
    }

    func filter<T:Object, K: Codable>(objectType: T.Type, key: String, value: K) -> [T]{
        var query = "\(key) contains '\(value)'"
        if value is Int {
            query = "\(key) = \(value)"
        }
        let objects = database.objects(objectType).filter(query).toArrayLimit20()
        guard let _objects = objects as? [T] else{
            return []
        }
        return _objects
    }
    
    func filterById<T:Object, K: Codable>(objectType: T.Type, value: K) -> T? {
        let object = database.object(ofType: objectType, forPrimaryKey: value)
        return object
    }

    func addObject<T:Object>(value: T) {
        try! database.write {
            database.add(value, update: Realm.UpdatePolicy.all)
        }
    }
    
    func addSequence<T: Object>(value: [T]){
        try! database.write {
            database.add(value)
        }
    }
}

extension Results {
    func toArray<T: Object>() -> [T] {
        var arr : [T] = []
        for item in self {
            if let _item = item as? T {
                arr.append(_item)
            }
        }
        return arr
    }

    func toArrayLimit20<T: Object>() -> [T] {
        var arr : [T] = []
        for item in self {
            if let _item = item as? T {
                arr.append(_item)
                if arr.count == 20 {
                    break
                }
            }
        }
        return arr
    }
}

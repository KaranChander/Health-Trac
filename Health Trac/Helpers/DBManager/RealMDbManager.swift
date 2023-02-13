//
//  RealMDbManager.swift
//  RealMDemo
//
//  Created by Appinventiv on 18/10/19.
//  Copyright © 2019 Appinventiv. All rights reserved.
//

import Foundation
import  RealmSwift

class RealmManager {
    let realm = try? Realm()
    
    // delete table
    func deleteDatabase() {
        try? realm?.write({
            realm?.deleteAll()
        })
    }
    
    // delete particular object
    func deleteObject(objs: Object) {
        try? realm!.write({
            realm?.delete(objs)
        })
    }
    
    //Save array of objects to database
    func saveObjects(objs: Object) {
        try? realm!.write({
            // If update = UpdatePolicy.error, adds the object
            realm?.add(objs, update: .error)
        })
    }
    
    // editing the object
    func editObjects(objs: Object) {
        try? realm!.write({
            // If update = true, objects that are already in the Realm will be
            // updated instead of added a new.
            realm?.add(objs, update: .all)
        })
    }
    
    //Returs an array as Results<object>?
    func getObjects(type: Object.Type) -> Results<Object>? {
        return realm!.objects(type)
    }
    
    func incrementID() -> Int {
        return (realm!.objects(ReadingsDetail.self).max(ofProperty: "id") as Int? ?? 0) + 1
    }
}

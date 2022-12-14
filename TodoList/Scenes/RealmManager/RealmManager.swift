//
//  RealmManager.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 14/12/22.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    let realm = try! Realm()
    
    func write(data: Task) {
        let todoData = TodoTask(taskName: data.title, priority: data.priority.rawValue)
        try! realm.write({
            realm.add(todoData)
        })
    }
    
    func read() -> [Task] {
        let task = realm.objects(TodoTask.self)
        return task.map { item in
            Task(title: item.taskName, priority: Priority(rawValue: item.priority) ?? .High )
        }
    }
    
    func update(_id: ObjectId) {
        
    }
    
    func delete(_id: ObjectId) {
        
    }
}

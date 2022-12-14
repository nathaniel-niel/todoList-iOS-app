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
    
    func read() -> [TodoListModel] {
        let task = realm.objects(TodoTask.self)
        return task.map { TodoListModel(
            id: $0._id.stringValue,
            title: $0.taskName,
            priority: Priority(rawValue: $0.priority) ?? .High )
        }
    }
    
    func update(_id: ObjectId) {
        
    }
    
    func delete(_id: String) {
        // get all data from realm
        let tasks = realm.objects(TodoTask.self)
        
        guard let id = try?  ObjectId(string: _id) else {
            return
        }
        
        let task = tasks.first(where: {$0._id == id})
        try! realm.write({
            realm.delete(task!)
        })
    }
}

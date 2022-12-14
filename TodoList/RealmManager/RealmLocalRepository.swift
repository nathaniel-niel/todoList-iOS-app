//
//  RealmLocalRepository.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 14/12/22.
//

import Foundation
import RealmSwift

class TodoTask: Object {
    
    @Persisted(primaryKey: true) var _id: ObjectId
    @Persisted var taskName: String
    @Persisted var date: Date
    @Persisted var priority: Int
    @Persisted var isDone: Bool
    
    
    convenience init(taskName: String, date: Date, priority: Int, isDone: Bool) {
        self.init()
        self.taskName = taskName
        self.date = date
        self.priority = priority
        self.isDone = isDone
    }
    
}

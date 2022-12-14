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
    @Persisted var priority: Int
    
    convenience init(taskName: String, priority: Int) {
        self.init()
        self.taskName = taskName
        self.priority = priority
    }
    
}

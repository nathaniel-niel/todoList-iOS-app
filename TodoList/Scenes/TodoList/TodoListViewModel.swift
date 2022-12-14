//
//  TodoListVewModel.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 14/12/22.
//

import Foundation
import UIKit
import RxSwift

class TodoListViewModel {
    
    var tasksSubject = PublishSubject<[Task]>()
    var filteredTaskObservable:Observable<[Task]> {
        return tasksSubject.asObservable()
    }
    var filteredTask: [Task] = []
    let realmManager = RealmManager()
    
    func getTodoListData(by priority: Priority?) {
        let tempTask = realmManager.read()
        
        if priority == nil || priority?.rawValue ?? 0 == 0 {
            tasksSubject.onNext(tempTask)
        } else {
            tasksSubject.onNext(tempTask.filter({$0.priority == priority}))
        }
    }
    
}

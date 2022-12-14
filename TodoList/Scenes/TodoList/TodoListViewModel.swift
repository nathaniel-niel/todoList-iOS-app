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
    
    var tasksSubject = PublishSubject<[TodoListModel]>()
    var filteredTaskObservable:Observable<[TodoListModel]> {
        return tasksSubject.asObservable()
    }
    var filteredTask: [TodoListModel] = []
    let realmManager = RealmManager()
    
    func getTodoListData(by priority: Priority?) {
        let tempTask = realmManager.read()
        
        if priority == nil || priority?.rawValue ?? 0 == 0 {
            tasksSubject.onNext(tempTask)
        } else {
            tasksSubject.onNext(tempTask.filter({$0.priority == priority}))
        }
    }
    
    func deleteTask(by id: String) {
        realmManager.delete(_id: id)
        getTodoListData(by: nil)
    }
}

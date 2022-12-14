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
    
    private var tasksSubject = PublishSubject<[TodoListModel]>()
    var filteredTaskObservable:Observable<[TodoListModel]> {
        return tasksSubject.asObservable()
    }
    private let realmManager = RealmManager()
    
    func getTodoListData(by priority: Priority?) {
        let tempTask = realmManager.read()
        
        if priority == nil || priority?.rawValue ?? 0 == 0 {
            tasksSubject.onNext(tempTask)
        } else {
            tasksSubject.onNext(tempTask.filter({$0.priority == priority}))
        }
    }
    
    func deleteTask(by id: String, currentSegment: Priority?) {
        realmManager.delete(_id: id)
        getTodoListData(by: currentSegment)
    }
}

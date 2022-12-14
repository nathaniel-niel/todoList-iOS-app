//
//  NewTaskViewModel.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 14/12/22.
//

import Foundation
import RxSwift

class NewTaskViewModel {

    let isSaveSucceed = PublishSubject<Bool>()
    let realmManager = RealmManager.shared
    
    var isSucceedObject: Observable<Bool> {
        return isSaveSucceed.asObservable()
    }
    
    func addNewTaskList(task: Task) {
        realmManager.write(data: task)
        isSaveSucceed.onNext(true)
    }
}

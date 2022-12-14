//
//  TodoListCoordinator.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 14/12/22.
//

import Foundation
import UIKit
import RxSwift


class TodoListCoordinator: BaseCoordinator {
    
    let disposeBag: DisposeBag = DisposeBag()
    let viewController = TodoListViewController()
    let viewModel = TodoListViewModel()
    
    override func start() {
        // compose todo list
        viewController.todoListViewModel  = viewModel
        viewController.routeAction = routeToAddNewTask
        navigationController.viewControllers = [viewController]
    }
    
    private func routeToAddNewTask() {
        let newTaskCoordinator = NewTaskCoordinator()
        
        newTaskCoordinator.viewModel.isSucceedObject
            .subscribe(onNext: { [unowned viewController] state in
                if state {
                    viewController.spinner.startAnimating()
                    viewController.segmentedControl.selectedSegmentIndex = 0
                    let priority = Priority(rawValue: viewController.segmentedControl.selectedSegmentIndex)
                    viewController.todoListViewModel.getTodoListData(by: priority)
                } else {
                    viewController.spinner.startAnimating()
                    print("faile get new list data")
                }
            }).disposed(by: disposeBag)
        
        newTaskCoordinator.navigationController = navigationController
        start(coordinator: newTaskCoordinator)
    }
}


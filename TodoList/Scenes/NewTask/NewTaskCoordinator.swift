//
//  NewTaskCoordinator.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 14/12/22.
//

import Foundation

class NewTaskCoordinator: BaseCoordinator {
    
    let viewController = NewTaskViewController()
    let viewModel = NewTaskViewModel()
    override func start() {
        // compose new task
        viewController.newTaskViewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
    }
}

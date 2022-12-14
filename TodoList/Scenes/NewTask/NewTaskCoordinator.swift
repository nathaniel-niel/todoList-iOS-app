//
//  NewTaskCoordinator.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 14/12/22.
//

import Foundation
import RxSwift

class NewTaskCoordinator: BaseCoordinator {
    
    private let disposeBag: DisposeBag = DisposeBag()
    let viewController = NewTaskViewController()
    let viewModel = NewTaskViewModel()
    
    override func start() {
        // compose new task
        viewController.newTaskViewModel = viewModel
        navigationController.pushViewController(viewController, animated: true)
        
        viewModel.onComplete.subscribe(onDisposed:  { [weak self] in
            guard let self = self else { return }
            self.parentCoordinator?.didFinish(coordinator: self)
        }).disposed(by: disposeBag)
        
    }
    
    
}

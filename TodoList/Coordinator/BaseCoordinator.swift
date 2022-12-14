//
//  BaseCoordinator.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 14/12/22.
//

import Foundation
import UIKit

protocol CoordinatorBuilder: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: CoordinatorBuilder? { get set }
    func start()
    func start(coordinator: CoordinatorBuilder)
    func didFinish(coordinator: CoordinatorBuilder)
}

class BaseCoordinator: CoordinatorBuilder {
    var navigationController: UINavigationController = UINavigationController()
    var parentCoordinator: CoordinatorBuilder?
    var childCoordinators: [CoordinatorBuilder] = []
    
    func start() {
        fatalError("start method must be implemented")
    }
    
    func start(coordinator: CoordinatorBuilder) {
        childCoordinators.append(coordinator)
        coordinator.parentCoordinator = self
        print(self)
        coordinator.start()
    }
    
    func didFinish(coordinator: CoordinatorBuilder) {
        if let coordinatorIndex = childCoordinators.firstIndex(where: {$0 === coordinator}) {
            childCoordinators.remove(at: coordinatorIndex)
            print ("\(coordinator) has been removed")
        }
    }
    
    
}

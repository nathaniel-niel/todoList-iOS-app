//
//  AppCoordinator.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 14/12/22.
//

import Foundation
import UIKit

class AppCoordinator: BaseCoordinator {
    var window: UIWindow?
    var windowScene: UIWindowScene?
    
    override func start() {
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.isTranslucent  = true
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        window?.windowScene = windowScene
        
        
        let coordinator = TodoListCoordinator()
        coordinator.navigationController = navigationController
        start(coordinator: coordinator)
        
    }
}

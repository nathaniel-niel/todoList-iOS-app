//
//  TaskModel.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 14/12/22.
//

import Foundation

enum Priority: Int {
    case High = 1
    case Medium = 2
    case low = 3
}

struct Task {
    let title: String
    let priority: Priority
}

//
//  TaskModel.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 14/12/22.
//

import Foundation

enum Priority: Int {
    case High
    case Medium
    case low
}

struct Task {
    let title: String
    let priority: Priority
}

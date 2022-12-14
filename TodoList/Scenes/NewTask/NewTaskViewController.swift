//
//  NewTaskViewController.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 14/12/22.
//

import Foundation
import UIKit


class NewTaskViewController: UIViewController {
    
    // MARK: - PROPERTIES
    let category: [String] = ["High", "Medium", "Low"]
    var newTaskViewModel = NewTaskViewModel()
    var saveAction: ((Task) -> Void)?
    
    // MARK: - UI COMPONENTS
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "e.g. study algorithm"
        textField.borderStyle = .roundedRect
        return textField
    }()
    
    // MARK: - LIFE CYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
    }
    
    private func setup() {
        view.backgroundColor = .white
        navigationItem.title = "Add New Task"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didSaveButtonTapped))
    }
    
    private func setupLayout() {
        view.addSubview(segmentedControl)
        view.addSubview(textField)
        
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            segmentedControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor, constant: 16),
            
            textField.topAnchor.constraint(equalToSystemSpacingBelow: segmentedControl.bottomAnchor, multiplier: 4),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: 16)
        ])
        
        category.enumerated().forEach { index, categoryItem in
            segmentedControl.insertSegment(withTitle: categoryItem, at: index, animated: true)
        }
        segmentedControl.selectedSegmentIndex = 0
    }
    
    @objc private func didSaveButtonTapped() {
        guard let priority = Priority.init(rawValue: segmentedControl.selectedSegmentIndex + 1) else { return }
        
        let task = Task(
            title: textField.text ?? "",
            priority: priority,
            date: Date(),
            isDone: false)
        newTaskViewModel.addNewTaskList(task: task)
        navigationController?.popViewController(animated: true)
    }
    
}

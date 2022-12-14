//
//  ViewController.swift
//  TodoList
//
//  Created by Nathaniel Andrian on 13/12/22.
//

import UIKit
import RxSwift

class TodoListViewController: UIViewController {
    
    // MARK: - PROPERTIES
    let category: [String] = ["All","High", "Medium", "Low"]
    let disposeBag = DisposeBag()
    var filteredTask: [Task] = []
    let todoListViewModel = TodoListViewModel()
    
    // MARK: - UI COMPONENTS
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return stackView
    }()
    
    let todoTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    let segmentedControl: UISegmentedControl = {
        let segmentedControl = UISegmentedControl()
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        return segmentedControl
    }()
    
    let spinner: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        return activityIndicator
    }()
    
    // MARK: - LIFE CYCLES
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUIComponents()
        bindData()
        let priority = Priority(rawValue: segmentedControl.selectedSegmentIndex)
        todoListViewModel.getTodoListData(by: priority)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        filteredTask.removeAll()
        DispatchQueue.main.async {
            self.todoTableView.reloadData()
        }
        spinner.startAnimating()
        
    }
    
    private func bindData() {
        spinner.startAnimating()
        todoListViewModel.filteredTaskObservable
            .delay(.milliseconds(1000), scheduler: MainScheduler.instance)
            .subscribe { [weak self] tasks in
            self?.filteredTask = tasks
            self?.updateTableView()
        } onCompleted: {
            print("all task completed")
        }.disposed(by: disposeBag)

    }
    
    private func setup() {
        navigationItem.title = "Todo List"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didAddButtonTapped))
        todoTableView.delegate = self
        todoTableView.dataSource = self
        todoTableView.backgroundView = spinner
    }
    
    private func setupUIComponents() {
        view.addSubview(stackView)
        stackView.addArrangedSubview(segmentedControl)
        stackView.addArrangedSubview(todoTableView)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            view.safeAreaLayoutGuide.trailingAnchor.constraint(equalTo: stackView.trailingAnchor),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(equalTo: stackView.bottomAnchor)
        ])
        
        category.enumerated().forEach { index, categoryItem in
            segmentedControl.insertSegment(withTitle: categoryItem, at: index, animated: true)
        }
        segmentedControl.addTarget(self, action: #selector(segmentedValueChanged(_:)), for: .valueChanged)
        segmentedControl.selectedSegmentIndex = 0
      
    }
    
    private func updateTableView() {
        todoTableView.reloadData()
        spinner.stopAnimating()
    }
    
    @objc private func segmentedValueChanged(_ sender:UISegmentedControl!) {
        let priority = Priority(rawValue: self.segmentedControl.selectedSegmentIndex)
        spinner.startAnimating()
        filteredTask.removeAll()
        DispatchQueue.main.async {
            self.todoTableView.reloadData()
        }
        todoListViewModel.getTodoListData(by: priority)
      }
    
    @objc private func didAddButtonTapped() {
        let vc = NewTaskViewController()
        vc.newTaskViewModel.isSucceedObject
            .subscribe(onNext: {[unowned self] state in
            if state {
                spinner.startAnimating()
                let priority = Priority(rawValue: self.segmentedControl.selectedSegmentIndex)
                self.todoListViewModel.getTodoListData(by: priority)
            } else {
                spinner.startAnimating()
                print("faile get new list data")
            }
        }).disposed(by: disposeBag)
        
        self.show(vc, sender: nil)
    }
}


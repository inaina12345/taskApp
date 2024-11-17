//
//  CreateTaskViewController.swift
//  taskApp
//
//  Created by mac on 2024/11/17.
//


import UIKit

class CreateTaskViewController: UIViewController {
    
    fileprivate var createTaskView: CreateTaskView!
    fileprivate var dataSource: TaskDataSource!
    fileprivate var taskText: String?
    fileprivate var taskDeadline: Date?

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white


        // CreateTaskViewを作成し、デリゲートにselfを設定している
        createTaskView = CreateTaskView()
        createTaskView.delegate = self
        view.addSubview(createTaskView)
        // TaskDataSource を生成...
        dataSource = TaskDataSource()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        createTaskView.frame = CGRect(x: view.safeAreaInsets.left,
                                      y: view.safeAreaInsets.top,
                                      width: view.frame.size.width - view.safeAreaInsets.left - view.safeAreaInsets.right,
                                      height: view.frame.size.height - view.safeAreaInsets.top - view.safeAreaInsets.bottom)
    }
    
    // 保存が完了した時のアラートを表示し、前の画面に戻っている
    fileprivate func showSaveAlert() {
        let alertController = UIAlertController(title: "保存しました！", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel) { (action) in
            self.navigationController?.popViewController(animated: true)
        }
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

    // タスク名が入力されていない時のアラート
    fileprivate func showMissingTaskTextAlert() {
        let alertController = UIAlertController(title: "タスクを入力してください", message: nil, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }

    //締切日が入力されていない時のアラート
    fileprivate func showMissingTaskDeadlineAlert() {
        let alertController = UIAlertController(title: "締切日を入力してください", message: nil, preferredStyle: .alert)
        // ...
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(action)
        present(alertController, animated: true, completion: nil)
    }
}

//CreateTaskViewDelegate メソッド
extension CreateTaskViewController: CreateTaskViewDelegate {
    func createView(taskEditing view: CreateTaskView, text: String) {
        // タスク内容が入力された時に呼ばれるデリゲートメソッド
        // CreateTaskViewからタスク内容を受け取り、taskTextに代入している
        taskText = text
    }

    func createView(deadlineEditing view: CreateTaskView, deadline: Date) {
        // 締切日が入力された時に呼ばれるデリゲートメソッド
        // CreateTaskViewから締切日を受け取り、taskDeadlineに代入している
        taskDeadline = deadline
    }

    func createView(saveButtonDidTap view: CreateTaskView) {
        // 保存ボタンがタップされた時に呼ばれるデリゲートメソッド
        // taskTextがnilだった場合はshowMissingTaskTextAlert()を表示
        // taskDeadlineがnilだった場合はshowMissingTaskDeadlineAlert()を表示
        // どちらもnilでない場合、taskTextとtaskDeadlineからTaskを作成し、
        // dataSource.save(task: task)で保存し、taskを保存してから
        // showSaveAlert()を呼んでいる
        guard let taskText = taskText else {
            showMissingTaskTextAlert()
            return
        }
        guard let taskDeadline = taskDeadline else {
            showMissingTaskDeadlineAlert()
            return
        }
        let task = Task(text: taskText, deadline: taskDeadline)
        dataSource.save(task: task)
        showSaveAlert()
    }
}

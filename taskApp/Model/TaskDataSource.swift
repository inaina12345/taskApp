//
//  TaskDataSource.swift
//  taskApp
//
//  Created by mac on 2024/11/17.
//

import Foundation

/*
 TaskDataSourceクラス

 プロパティ:
 tasks: Taskの配列（UITableViewで表示するためのデータ）
 メソッド:
 loadData(): UserDefaultsから保存されたTask一覧を取得し、tasks配列に格納する
 */
class TaskDataSource: NSObject {
    // Task一覧を保持するArray
    private var tasks = [Task]()

    // UserDefaultsから保存したTask一覧を取得している
    func loadData() {
        let userDefaults = UserDefaults.standard
        let taskDictionaries = userDefaults.object(forKey: "tasks") as? [[String: Any]]

        guard let taskDictionaries else { return }

        for dic in taskDictionaries {
            let task = Task(from: dic)
            tasks.append(task)
        }
    }
    
    // TaskをUserDefaultsに保存している
    func save(task: Task) {
        tasks.append(task)

        var taskDictionaries: [[String: Any]] = []
        for t in tasks {
            let taskDictionary: [String: Any] = ["text": t.text,
                                               "deadline": t.deadline]
            taskDictionaries.append(taskDictionary)
        }

        let userDefaults = UserDefaults.standard
        userDefaults.set(taskDictionaries, forKey: "tasks")
        userDefaults.synchronize()
    }

    // Taskの数を返している。UITableViewのcellのカウントに使用する
    func count() -> Int {
        return tasks.count
    }

    // 指定したindexに対応するTaskを返している。indexにはUITableViewのIndexPath.rowがくることを想定している
    func data(at index: Int) -> Task? {
        if tasks.count > index {
            return tasks[index]
        }
        return nil
    }
    
    /*
     // taskをNSCodingプロトコルに準拠させ、tasksをDataに変換して保存する方法は以下のようなコードになります。
    class Task: NSObject, NSCoding {
        let text: String
        let deadline: Date

        func encode(with aCoder: NSCoder) {
            aCoder.encode(text, forKey: "text")
            aCoder.encode(deadline, forKey: "deadline")
        }

        required init?(coder aDecoder: NSCoder) {
            text = aDecoder.decodeObject(forKey: "text") as! String
            deadline = aDecoder.decodeObject(forKey: "deadline") as! Date

        }
    }

    // UserDefaultsにNSCodingプロトコルに準拠させたTaskを持つArrayを保存する方法
    func save(task: Task) {
        tasks.append(task)

        let encodedTasks = NSKeyedArchiver.archivedData(withRootObject: tasks)
        let userDefaults = UserDefaults.standard
        userDefaults.set(encodedTasks, forKey: "tasks")
        userDefaults.synchronize()
    }
     */
}

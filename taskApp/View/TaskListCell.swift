//
//  TaskListCell.swift
//  taskApp
//
//  Created by mac on 2024/11/17.
//

import UIKit

/*
 View 層の役割は、Controllerからデータを受け取りUIに反映させることです。

 TaskListCell という UITableViewCell を継承した Class を作ります。
 */

class TaskListCell: UITableViewCell {
    private var taskLabel: UILabel! // タスク内容を表示する Label
    private var deadlineLabel: UILabel! // deadlineを表示する Label

    var task: Task? {
        didSet {
            guard let t = task else {
                return
            }
            taskLabel.text = t.text
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            deadlineLabel.text = formatter.string(from: t.deadline)
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        taskLabel = UILabel()
        taskLabel.textColor = UIColor.black
        taskLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(taskLabel)
        
        deadlineLabel = UILabel()
        deadlineLabel.textColor = UIColor.black
        deadlineLabel.font = UIFont.systemFont(ofSize: 14)
        contentView.addSubview(deadlineLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        taskLabel.frame = CGRect(x: 15.0,
                                 y: 15.0,
                                 width: contentView.frame.width - 15.0 * 2,
                                 height: 15.0)
        
        deadlineLabel.frame = CGRect(x: taskLabel.frame.origin.x,
                                     y: taskLabel.frame.maxY + 8.0,
                                     width: taskLabel.frame.width,
                                     height: 15.0)
    }
    
}

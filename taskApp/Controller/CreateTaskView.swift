//
//  CreateTaskView.swift
//  taskApp
//
//  Created by mac on 2024/11/17.
//

import UIKit

protocol CreateTaskViewDelegate: AnyObject {
    func createView(taskEditing view: CreateTaskView, text: String)
    func createView(deadlineEditing view: CreateTaskView, deadline: Date)
    func createView(saveButtonDidTap view: CreateTaskView)
}


class CreateTaskView: UIView {
    private var taskTextField: UITextField! // タスク内容を入力するUITextField
    private var datePicker: UIDatePicker! // 締め切り時間を表示するUIPickerView
    private var deadlineTextField: UITextField! // 締め切り時間を入力するUITextField
    private var saveButton: UIButton! // 保存ボタン
    weak var delegate: CreateTaskViewDelegate? // デリゲート
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    required override init(frame: CGRect) {
        super.init(frame: frame)

        // タスク名入力用のテキストフィールドを作成
        taskTextField = UITextField()
        taskTextField.delegate = self
        taskTextField.tag = 0
        taskTextField.placeholder = "予定を入力してください"
        addSubview(taskTextField)

        // 期限入力用のテキストフィールドと日付ピッカーを作成
        deadlineTextField = UITextField()
        deadlineTextField.tag = 1
        deadlineTextField.placeholder = "期限を入力してください"
        addSubview(deadlineTextField)

        datePicker = UIDatePicker()
        datePicker.datePickerMode = .dateAndTime
        if #available(iOS 14, *) {
            datePicker.preferredDatePickerStyle = .wheels
            datePicker.sizeToFit()
        }
        // デートピッカーの値が変更されたときに呼び出すメソッドを設定
        datePicker.addTarget(self, action: #selector(datePickerValueChanged(_:)), for: .valueChanged)
        // テキストフィールドが編集モードになったときに、キーボードではなく、デートピッカーを表示するように設定
        deadlineTextField.inputView = datePicker

        // 保存ボタンを作成
        saveButton = UIButton()
        saveButton.setTitle("保存する", for: .normal)
        saveButton.setTitleColor(UIColor.black, for: .normal)
        saveButton.layer.borderWidth = 0.5
        saveButton.layer.cornerRadius = 4.0
        saveButton.addTarget(self, action: #selector(saveButtonTapped(_:)), for: .touchUpInside)
        addSubview(saveButton)
    }

    @objc func saveButtonTapped(_ sender: UIButton) {
        // delegate?.createView(saveButtonDidTap: self)
        // この行で、保存ボタンがタップされたことをCreateTaskViewControllerに通知している
        delegate?.createView(saveButtonDidTap: self)
    }
    
    @objc func datePickerValueChanged(_ sender: UIDatePicker) {
        // UIDatePickerの値が変わった時に呼ばれるメソッド

        // sender.dateがユーザーが選択した締め切り日時で、DateFormatterを用いて
        // Stringに変換し、deadlineTextField.textに入れている

        // また、日時の情報をCreateTaskViewControllerへ伝達している

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
        let deadlineText = dateFormatter.string(from: sender.date)
        deadlineTextField.text = deadlineText
        delegate?.createView(deadlineEditing: self, deadline: sender.date)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        taskTextField.frame = CGRect(x: bounds.origin.x + 30,
                                     y: bounds.origin.y + 30,
                                     width: bounds.size.width - 60,
                                     height: 50)

        deadlineTextField.frame = CGRect(x: taskTextField.frame.origin.x,
                                          y: taskTextField.frame.maxY + 30,
                                          width: taskTextField.frame.size.width,
                                          height: taskTextField.frame.size.height)

        let saveButtonSize = CGSize(width: 100, height: 50)
        saveButton.frame = CGRect(x: (bounds.size.width - saveButtonSize.width) / 2,
                                  y: deadlineTextField.frame.maxY + 20,
                                  width: saveButtonSize.width,
                                  height: saveButtonSize.height)
    }
}

extension CreateTaskView: UITextFieldDelegate {
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if textField.tag == 0 {
            /*
            textField.tagで識別している。もしtagが0の時、textField.textすなわち、
            ユーザーが入力したタ
スク内容の文字をCreateTaskViewControllerに返している
            */
            delegate?.createView(taskEditing: self, text: textField.text ?? "")
        }
        return true
    }
}



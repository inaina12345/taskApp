//
//  Task.swift
//  taskApp
//
//  Created by mac on 2024/11/17.
//

import Foundation

class Task {
    
    let text: String // タスクの内容
    let deadline: Date // タスクの締め切り時間
    
    /*
     引数からtextとdeadlineを受け取りTaskを生成するイニシャライザメソッド
     
     千葉 大志. iOSアプリ開発デザインパターン入門 技術の泉シリーズ (技術の泉シリーズ（NextPublishing）) (pp.151-152). インプレスR&D. Kindle 版.
     */
    init (text: String, deadline: Date) {
        self.text = text
        self.deadline = deadline
    }
    
    /*
     引数のdictionaryからTaskを生成するイニシャライザ
     UserDefaultで保存したdictionaryから生成することを目的としている
     */
    init(from dictionary: [String: Any]) {
        self.text = dictionary["text"] as! String
        self.deadline = dictionary["deadline"] as! Date
    }
    
}



extension Task {
    func testprintdebug() {
        let tas = Task(text: "aaa", deadline: Date.now)
        print(tas.text)
        print(tas.deadline)
        
    }
}



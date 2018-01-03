//
//  ViewController.swift
//  MyTodoList
//
//  Created by 前俊輔 on 2018/01/03.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var todoList = [String]()
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // NavigationBarの+ボタンをタップしたときの処理
    @IBAction func tapAddButton(_ sender: Any) {
        // アラートダイアログを生成
        let alertController = UIAlertController(title: "ToDo追加", message: "ToDoを追加してください", preferredStyle: UIAlertControllerStyle.alert)
        // アラートダイアログにテキストエリアを追加
        alertController.addTextField(configurationHandler: nil)

        // OKボタンがタップされたときの処理
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (action: UIAlertAction) in
            // OKボタンがタップされたときの処理
            if let textField = alertController.textFields?.first {
                // ToDoの配列の先頭に入力値を挿入
                self.todoList.insert(textField.text!, at: 0)
                
                // テーブルに行が追加されたことをテーブルに通知
                self.tableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: UITableViewRowAnimation.right)
            }
        }
        // OKボタンを追加
        alertController.addAction(okAction)
        
        // CANCELボタンがタップされたときの処理
        let cancelButton = UIAlertAction(title: "CANCEL", style: UIAlertActionStyle.cancel, handler: nil)
        // CANCELボタンを追加
        alertController.addAction(cancelButton)
        
        // アラートダイアログを表示
        present(alertController, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // StoryBoardで指定したtodoCell識別子を利用して再利用可能なセルを取得する
        let cell = tableView.dequeueReusableCell(withIdentifier: "todoCell", for: indexPath)
        
        // 行番号に合ったToDoのタイトルを取得
        let todoTitle = todoList[indexPath.row]
        // セルのラベルにToDoのタイトルをセット
        cell.textLabel?.text = todoTitle

        return cell
    }
}


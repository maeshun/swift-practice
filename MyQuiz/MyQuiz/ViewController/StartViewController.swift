//
//  StartViewController.swift
//  MyQuiz
//
//  Created by 前俊輔 on 2018/01/08.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 問題の読み込み
        QuestionDataManager.sharedInstance.loadQuestion()
        
        // 遷移先画面の呼び出し
        guard let nextViewController = segue.destination as? QuestionViewController else {
            // 取得できずに終了
            return
        }
        
        // 問題文の取り出し
        guard let questionData = QuestionDataManager.sharedInstance.nextQuestion() else {
            // 取得できずに終了
            return
        }
        
        // 問題文のセット
        nextViewController.questionData = questionData
    }
    
    // タイトルに戻ってくるときに呼び出される処理
    @IBAction func goToTitle(_ segue: UIStoryboardSegue) {
        
    }
}


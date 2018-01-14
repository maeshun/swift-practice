//
//  ResultViewController.swift
//  MyQuiz
//
//  Created by 前俊輔 on 2018/01/14.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    @IBOutlet weak var correctPercentLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        viewInit()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func viewInit() {
        let questionCount: Int = QuestionDataManager.sharedInstance.questionDataArray.count
        
        // 正解数を取得
        var correctCount: Int = 0
        for questionData in QuestionDataManager.sharedInstance.questionDataArray {
            if questionData.isCorrect() {
                correctCount += 1
            }
        }
        
        let correctPercent: Float = (Float(correctCount
        ) / Float(questionCount)) * 100
        
        correctPercentLabel.text = String(format: "%.1f ", correctPercent) + "%"
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

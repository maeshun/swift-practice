//
//  QuestionViewController.swift
//  MyQuiz
//
//  Created by 前俊輔 on 2018/01/14.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit
import AudioToolbox

class QuestionViewController: UIViewController {

    // 質問番号ラベル
    @IBOutlet weak var questionNoLabel: UILabel!
    // 問題文テキスト
    @IBOutlet weak var questionTextView: UITextView!
    
    // 選択肢のボタン
    @IBOutlet weak var answer1Button: UIButton!
    @IBOutlet weak var answer2Button: UIButton!
    @IBOutlet weak var answer3Button: UIButton!
    @IBOutlet weak var answer4Button: UIButton!
    
    // 正解/不正解時のイメージ
    @IBOutlet weak var correctImageView: UIImageView!
    @IBOutlet weak var incorrectImageView: UIImageView!
    
    // 必ず受け取るデータなので強制アンラップ
    var questionData: QuestionData!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewInit()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    private func viewInit() {
        self.questionNoLabel.text = "Q.\(self.questionData.questionNo)"
        self.questionTextView.text = self.questionData.question
        self.answer1Button.setTitle(self.questionData.answer1, for: UIControlState.normal)
        self.answer2Button.setTitle(self.questionData.answer2, for: UIControlState.normal)
        self.answer3Button.setTitle(self.questionData.answer3, for: UIControlState.normal)
        self.answer4Button.setTitle(self.questionData.answer4, for: UIControlState.normal)
    }
    
    @IBAction func tapAnswer1Button(_ sender: Any) {
        self.questionData.userSelectedAnswerNumber = 1
        goNextQuestionWithAnimation()
    }

    @IBAction func tapAnswer2Button(_ sender: Any) {
        self.questionData.userSelectedAnswerNumber = 2
        goNextQuestionWithAnimation()
    }
    
    @IBAction func tapAnswer3Button(_ sender: Any) {
        self.questionData.userSelectedAnswerNumber = 3
        goNextQuestionWithAnimation()
    }
    
    @IBAction func tapAnswer4Button(_ sender: Any) {
        self.questionData.userSelectedAnswerNumber = 4
        goNextQuestionWithAnimation()
    }
    
    
    private func goNextQuestionWithAnimation() {
        if self.questionData.isCorrect() {
            // 正解のアニメーション
            goNextQuestionWithCorrectAnimation()
        } else {
            // 不正解のアニメーション
            goNextQuestionWithIncorrectAnimation()
        }
    }

    private func goNextQuestionWithCorrectAnimation() {
        // 正解のサウンドを鳴らす
        AudioServicesPlayAlertSound(1025)
        
        // アニメーション
        UIView.animate(withDuration: 2.0, animations: {
            // アルファを変動
            self.correctImageView.alpha = 1.0
        }) { (Bool) in
            self.goNextQuestion()
        }
    }
    
    private func goNextQuestionWithIncorrectAnimation() {
        // 不正解のサウンドを鳴らす
        AudioServicesPlayAlertSound(1006)
        
        // アニメーション
        UIView.animate(withDuration: 2.0, animations: {
            // アルファを変動
            self.incorrectImageView.alpha = 1.0
        }) { (Bool) in
            self.goNextQuestion()
        }

    }
    
    private func goNextQuestion() {
//        let nextQuestion: QuestionData? = QuestionDataManager.sharedInstance.nextQuestion()

        // 次の問題がない場合は結果画面へ遷移する
        guard let nextQuestion: QuestionData = QuestionDataManager.sharedInstance.nextQuestion() else {
            // StoryboardのIdentifierに設定した値（result）を設定して
            // ViewControllerを生成する
            if let resultViewController = storyboard?.instantiateViewController(withIdentifier: "result") as? ResultViewController {
                // Storyboardのsegueを利用しない画面遷移処理
                present(resultViewController, animated: true, completion: nil)
            }
            return
        }
        
        // 次の問題がある場合は次の問題へ遷移する
        // StoryboardのIdentifierに設定した値（question）を設定して
        // ViewControllerを生成する
        if let nextQuestionViewController = storyboard?.instantiateViewController(withIdentifier: "question") as? QuestionViewController {
            nextQuestionViewController.questionData = nextQuestion
            // Storyboardのsegueを利用しない画面遷移処理
            present(nextQuestionViewController, animated: true, completion: nil)
        }
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

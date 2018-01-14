//
//  QestionDataManager.swift
//  MyQuiz
//
//  Created by 前俊輔 on 2018/01/14.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//
import Foundation

class QuestionDataManager {
    // シングルトンオブジェクト
    static let sharedInstance = QuestionDataManager()
    
    var questionDataArray: [QuestionData] = [QuestionData]()
    
    var nowQuestionIndex: Int = 0
    
    private init() {
        // シングルトンであることを保証するためにprivateで宣言する
    }
    
    
    func loadQuestion() {
        // 質問を空にする
        self.questionDataArray.removeAll()
        // 現在の問題のインデックスを初期化
        self.nowQuestionIndex = 0
        
        // csvファイルパスを取得
        guard let csvFilePath = Bundle.main.path(forResource: "question", ofType: "csv") else {
            print("csvファイルが存在しません")
            return
        }
        
        // csvファイルの読み込み
        do {
            let csvStringData = try String(contentsOfFile: csvFilePath, encoding: String.Encoding.utf8)
            // csvデータを1行ずつ読み込む
            csvStringData.enumerateLines(invoking: { (line, stop) in
                // カンマ区切りで分割
                let questionSourceDataArray = line.components(separatedBy: ",")
                // 問題データを格納するオブジェクトを作成
                let questionData = QuestionData(questionSourceDataArray: questionSourceDataArray)
                // 問題を追加
                self.questionDataArray.append(questionData)
                // 問題番号を設定
                questionData.questionNo = self.questionDataArray.count
                print(String(questionData.questionNo))
            })

        } catch let error {
            print("csvファイル読み込みエラーが発生しました: \(error)")
            return
        }
    }
    
    // 次の質問を取り出す
    func nextQuestion() -> QuestionData? {
        if self.nowQuestionIndex < self.questionDataArray.count {
            let nextQuestion = questionDataArray[self.nowQuestionIndex]
            self.nowQuestionIndex += 1
            return nextQuestion
        }
        return nil
    }
    
}

class QuestionData {
    // 問題文
    var question: String

    // 選択肢
    var answer1: String
    var answer2: String
    var answer3: String
    var answer4: String
    
    // 正解の番号
    var correctAnswerNumber: Int
    
    // ユーザーが選択した選択肢の番号
    var userSelectedAnswerNumber: Int?
    
    // 問題文の番号
    var questionNo: Int = 0
    
    init(questionSourceDataArray: [String]) {
        self.question = questionSourceDataArray[0]
        self.answer1 = questionSourceDataArray[1]
        self.answer2 = questionSourceDataArray[2]
        self.answer3 = questionSourceDataArray[3]
        self.answer4 = questionSourceDataArray[4]
        self.correctAnswerNumber = Int(questionSourceDataArray[5])!
    }
    
    // 正解判定
    func isCorrect() -> Bool {
        if self.correctAnswerNumber == self.userSelectedAnswerNumber {
            return true
        }
        return false
    }
}

//
//  ViewController.swift
//  SampleQuiz
//
//  Created by 前俊輔 on 2018/01/08.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit
import AudioToolbox

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func tapSystemSound(_ sender: Any) {
        AudioServicesPlaySystemSoundWithCompletion(1000) {
            
        }
    }
    
    @IBAction func tapCustomSound(_ sender: Any) {
        // サウンドファイルは再生時間が30秒以下であること
        let soundUrl = Bundle.main.url(forResource: "custom", withExtension: "mp3")

        // サウンドIDを登録する
        var soundId: SystemSoundID = 0
        // サウンドファイルを登録してサウンドIDを取得
        AudioServicesCreateSystemSoundID(soundUrl! as CFURL, &soundId)
        // 取得したサウンドIDを使用してサウンドを鳴らす
        AudioServicesPlaySystemSoundWithCompletion(soundId) {
            
        }
    }

    @IBAction func tapVibration(_ sender: Any) {
        AudioServicesPlaySystemSoundWithCompletion(kSystemSoundID_Vibrate) {
            
        }
    }
    

}


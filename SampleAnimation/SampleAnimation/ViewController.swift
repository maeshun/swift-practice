//
//  ViewController.swift
//  SampleAnimation
//
//  Created by 前俊輔 on 2018/01/08.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var targetView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func tapStartButton(_ sender: Any) {
        // ビューの角を丸める処理をアニメーションで表現する
        let animation = CABasicAnimation(keyPath: "cornerRadius")
        // イージングの設定
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
        animation.fromValue = 0
        animation.toValue = 20
        // アニメーション秒数指定
        animation.duration = 1
        // アニメーションをレイヤーに追加する
        targetView.layer.add(animation, forKey: "cornerRadius")
        // アニメーション後も角丸を維持する
        targetView.layer.cornerRadius = 20

        // シンプルな記述方法
        self.targetView.alpha = 1
        UIView.animate(withDuration: 1.0) {
            self.targetView.alpha = 0
        }
    }
}


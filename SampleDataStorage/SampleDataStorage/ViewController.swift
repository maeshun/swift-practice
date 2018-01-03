//
//  ViewController.swift
//  SampleDataStorage
//
//  Created by 前俊輔 on 2018/01/03.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaultsインスタンスの参照
        let userDefaults = UserDefaults.standard
        // key名textを取得する
        if let value = userDefaults.string(forKey: "text") {
            textField.text = value
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func tapActionButton(_ sender: Any) {
        let userDefaults = UserDefaults.standard
        // キー名textで値を保存（この時点ではメモリ上）
        userDefaults.set(textField.text, forKey: "text")
        // UserDefaultsへの値の保存
        userDefaults.synchronize()
    }
    


}


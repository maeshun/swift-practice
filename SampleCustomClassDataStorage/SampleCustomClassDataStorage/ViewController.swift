//
//  ViewController.swift
//  SampleCustomClassDataStorage
//
//  Created by 前俊輔 on 2018/01/03.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 画面表示時にデータを格納
        let userDefaults = UserDefaults.standard
        let data = MyData()
        data.valueString = "test"

        // シリアライズ処理
        // NSKeyedArchiver内で、MyData.encodeが呼ばれる？
        let archiveData = NSKeyedArchiver.archivedData(withRootObject: data)
        // UserDefaultに保存
        userDefaults.set(archiveData, forKey: "data")
        userDefaults.synchronize()
        
        // デシリアライズ処理
        if let storeData = userDefaults.object(forKey: "data") as? Data {
            // シリアライズされたデータをデシリアライズし、MyData型へ変換する
            // NSKeyedUnarchiver内で、MyData.initが呼ばれる？
            if let unarchiveData = NSKeyedUnarchiver.unarchiveObject(with: storeData) as? MyData {
                if let valueString = unarchiveData.valueString {
                    print("デシリアライズデータ: "+valueString)
                }
            }
        }
        
//        userDefaults.set(data, forKey: "data")
//        userDefaults.synchronize()
//        print("viewDidLoad")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


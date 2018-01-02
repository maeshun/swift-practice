//
//  ViewController.swift
//  MyCalc
//
//  Created by 前俊輔 on 2018/01/02.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var priceField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 次の画面を取得
        let viewController = segue.destination as! PercentViewController
        
        if let price = Int(priceField.text!) {
            // 数値に変換した金額を次の画面に設定する
            viewController.price = price
        }
    }
    
    
    // 結果画面からもどって来たときの処理
    @IBAction func restart(_ segue: UIStoryboardSegue) {
        priceField.text = "0"
    }

    @IBAction func tap1Button(_ sender: Any) {
        setNumber("1")
    }

    @IBAction func tap2Button(_ sender: Any) {
        setNumber("2")
    }
    
    @IBAction func tap3Button(_ sender: Any) {
        setNumber("3")
    }

    @IBAction func tap4Button(_ sender: Any) {
        setNumber("4")
    }
    
    @IBAction func tap5Button(_ sender: Any) {
        setNumber("5")
    }
    
    @IBAction func tap6Button(_ sender: Any) {
        setNumber("6")
    }
    
    @IBAction func tap7Button(_ sender: Any) {
        setNumber("7")
    }
    
    @IBAction func tap8Button(_ sender: Any) {
        setNumber("8")
    }
    
    @IBAction func tap9Button(_ sender: Any) {
        setNumber("9")
    }
    
    @IBAction func tap0Button(_ sender: Any) {
        setNumber("0")
    }
    
    @IBAction func tap00Button(_ sender: Any) {
        setNumber("00")
    }
    
    @IBAction func tapCButton(_ sender: Any) {
        priceField.text = "0";
    }
    
    private func setNumber(_ num: String) {
        let value = priceField.text! + num
        if let price = Int(value) {
            priceField.text = "\(price)"
        }
    }
    
}


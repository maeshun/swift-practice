//
//  PercentViewController.swift
//  MyCalc
//
//  Created by 前俊輔 on 2018/01/03.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit

class PercentViewController: UIViewController {

    // 金額を受け取るプロパティ
    var price: Int = 0
    
    // 割引パーセント入力フィールド
    @IBOutlet weak var percentField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! ResultViewController
        
        viewController.price = price
        if let percent = Int(percentField.text!) {
            viewController.percent = percent
        }
    }
    

    
    
    @IBAction func tap0Button(_ sender: Any) {
        setPercent("0")
    }
    
    @IBAction func tap1Button(_ sender: Any) {
        setPercent("1")
    }
    
    @IBAction func tap2Button(_ sender: Any) {
        setPercent("2")
    }
    
    @IBAction func tap3Button(_ sender: Any) {
        setPercent("3")
    }
    
    @IBAction func tap4Button(_ sender: Any) {
        setPercent("4")
    }
    
    @IBAction func tap5Button(_ sender: Any) {
        setPercent("5")
    }
    
    @IBAction func tap6Button(_ sender: Any) {
        setPercent("6")
    }
    
    @IBAction func tap7Button(_ sender: Any) {
        setPercent("7")
    }
    
    @IBAction func tap8Button(_ sender: Any) {
        setPercent("8")
    }
    
    @IBAction func tap9Button(_ sender: Any) {
        setPercent("9")
    }
    
    @IBAction func tapCButton(_ sender: Any) {
        percentField.text = "0"
    }
    
    
    private func setPercent(_ value: String) {
        let percent = percentField.text! + value
        if let percent = Int(percent) {
            percentField.text = "\(percent)"
        }
    }
    
    
}

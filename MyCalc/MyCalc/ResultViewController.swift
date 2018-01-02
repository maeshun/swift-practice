//
//  ResultViewController.swift
//  MyCalc
//
//  Created by 前俊輔 on 2018/01/03.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {

    var price: Int = 0
    var percent: Int = 0
    
    @IBOutlet weak var resultField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let percentValue: Float = Float(percent) / 100
        let discountPrice: Float = Float(price) * percentValue
        let discountedPrice: Int = price - Int(discountPrice)
        
        resultField.text = "\(discountedPrice)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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

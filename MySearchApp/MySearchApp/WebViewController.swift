//
//  WebViewController.swift
//  MySearchApp
//
//  Created by 前俊輔 on 2018/04/21.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    var itemUrl: String?
    
    @IBOutlet weak var wkWebView: WKWebView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserAgentをiPhoneに設定
        wkWebView.customUserAgent = ""
        // webViewのurlを読み込ませてwebページを表示させる
        guard let itemUrl = self.itemUrl else {
            return
        }
        guard let url = URL(string: itemUrl) else {
            return
        }
        let request = URLRequest(url: url)
        self.wkWebView.load(request)
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

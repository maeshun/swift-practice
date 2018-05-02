//
//  SearchItemTableViewContoller.swift
//  MySearchApp
//
//  Created by 前俊輔 on 2018/04/21.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import UIKit

class SearchItemTableViewContoller: UITableViewController {

    @IBOutlet weak var searchBar: UISearchBar!

    let entryUrl: String = "https://shopping.yahooapis.jp/ShoppingWebService/V1/json/itemSearch"
    let appId: String = ""
    let priceFormatter = NumberFormatter()
    
    var itemDataArray = [ItemData]()
    var imageCache = NSCache<AnyObject, UIImage>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        priceFormatter.numberStyle = .currency
        priceFormatter.currencyCode = "JPY"
        
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // リクエストする
    func request(requestString: String) {
        // URL生成
        guard let url = URL(string: requestString) else { return }
        // リクエスト生成
        let request = URLRequest(url: url)
        // 商品検索APIをコール
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            // 通信完了後の処理
            // エラーチェック
            guard error == nil else {
                // エラー表示
                let alert = UIAlertController(title: "エラー",
                                              message: error?.localizedDescription,
                                              preferredStyle: UIAlertControllerStyle.alert)
                // UIに関する処理はメインスレッドで行う
                DispatchQueue.main.async {
                    self.present(alert, animated: true, completion: nil)
                }
                return
            }
            
            // jsonデータのパース
            guard let data = data else { return }
            
            do {
                // パース実施
                let resultSet = try JSONDecoder().decode(ItemSearchResultSet.self, from: data)
                // 商品リストに追加
                self.itemDataArray.append(contentsOf: resultSet.resultSet.firstObject.result.items)
            } catch let error {
                print("## error: \(error)")
            }
            
            // テーブルの描画処理
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
        
        // 通信開始
        task.resume()
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.itemDataArray.count
    }
    
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "itemCell", for: indexPath) as? ItemTableViewCell else {
            return UITableViewCell()
        }
        
        let itemData = self.itemDataArray[indexPath.row]
        cell.itemTitleLabel.text = itemData.name
        let number = NSNumber(integerLiteral: Int(itemData.priceInfo.price!)!)
        cell.itemPriceLabel.text = priceFormatter.string(from: number)
        cell.itemUrl = itemData.url
        
        // 画像の設定
        guard let itemImageUrl = itemData.imageInfo.medium else {
            // 画像なし商品
            return cell
        }
        // キャッシュの画像を取り出す
        if let chacheImage = imageCache.object(forKey: itemImageUrl as AnyObject) {
            // キャッシュ画像の設定
            cell.itemImageView.image = chacheImage
            return cell
        }

        // キャッシュなしなのでダウンロード
        guard let url = URL(string: itemImageUrl) else {
            return cell
        }
        
        let request = URLRequest(url: url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
            
            guard error == nil else { return }
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            // ダウンロードした画像をキャッシュに保存
            self.imageCache.setObject(image, forKey: itemImageUrl as AnyObject)
            // 画像はメインスレッド上で設定
            DispatchQueue.main.async {
                cell.itemImageView.image = image
            }
        }
        // 画像読み込み処理開始
        task.resume()
        
        return cell
    }

    // 商品タップで次の画面に遷移する前の処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? ItemTableViewCell {
            if let webViewController = segue.destination as? WebViewController {
                webViewController.itemUrl = cell.itemUrl
            }
        }
    }

}

extension SearchItemTableViewContoller: UISearchBarDelegate {
    // searchボタンがタップされたときの処理
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 入力された文字の取り出し
        guard let inputText = searchBar.text else { return }
        // 入力文字数
        guard inputText.lengthOfBytes(using: String.Encoding.utf8) > 0 else { return }
        // 保持している商品の破棄
        itemDataArray.removeAll()
        // パラメータ指定
        let parameter = ["appid": self.appId, "query": inputText]
        // パラメータをエンコードしたURLを作成
        let requestUrl = createRequestUrl(parameter: parameter)
        request(requestString: requestUrl)
        // キーボード閉じる
        self.searchBar.resignFirstResponder()
    }
    
    // URL作成
    func createRequestUrl(parameter: [String: String]) -> String {
        var parameterString:String = ""
  
        for key in parameter.keys {
            // 値の取り出し
            guard let value = parameter[key] else { continue }
            // すでにパラメータが設定されていた場合
            if parameterString.lengthOfBytes(using: String.Encoding.utf8) > 0 {
                parameterString += "&"
            }
            // 値をエンコード
            guard let encodeValue = encodeParameter(key: key, value: value) else { continue }
            // エンコードした値をパラメータとして追加
            parameterString += encodeValue
        }
        let requestUrl: String = self.entryUrl + "?" + parameterString
        print(requestUrl)
        return requestUrl
    }
    
    // urlエンコード
    func encodeParameter(key: String, value: String) -> String? {
        // 値をエンコードする
        guard let escapedValue = value.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed) else {
            // エンコード失敗
            return nil
        }
        return "\(key)=\(escapedValue)"
    }

}

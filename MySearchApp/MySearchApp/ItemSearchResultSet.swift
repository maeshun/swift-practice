//
//  ItemSearchResultSet.swift
//  MySearchApp
//
//  Created by 前俊輔 on 2018/01/15.
//  Copyright © 2018年 Shunsuke Mae. All rights reserved.
//

import Foundation


// 検索結果全体を格納するクラス
class ItemSearchResultSet: Codable {
    var resultSet: ResultSet
    
    private enum CodingKeys: String, CodingKey {
        case resultSet = "ResultSet"
    }
}

// 検索絵結果セット格納クラス
class ResultSet: Codable {
    var firstObject: FirstObject
    
    private enum CodingKeys: String, CodingKey {
        case firstObject = "0"
    }
}

// 検索結果の先頭を格納するクラス
class FirstObject: Codable {
    var result: Result
    
    private enum CodingKeys: String, CodingKey {
        case result = "Result"
    }
}

// 検索結果格納クラス
class Result: Codable {
    var items: [ItemData] = [ItemData]()
    
    required init(from decoder: Decoder) throws {
        // デコードのためのコンテナを取得
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // コンテナ内のキーを取得。キーが文字列であるため、数値の照準ソートも行う
        let keys = container.allKeys.sorted {
            Int($0.rawValue)! < Int($1.rawValue)!
        }
        // キーを使用して検索結果を一件ずつ取り出す
        for key in keys {
            // 検索結果一件に対するデコード処理
            let item = try container.decode(ItemData.self, forKey: key)
            // デコード処理ができたら検索結果の一覧に追加
            items.append(item)
        }
    }
    
    // エンコード処理
    func encode(to encoder: Encoder) throws {
        // レスポンスを解析するだけなので実装不要
    }
    
    private enum CodingKeys: String, CodingKey {
        case hit0 = "0"
        case hit1 = "1"
        case hit2 = "2"
        case hit3 = "3"
        case hit4 = "4"
        case hit5 = "5"
        case hit6 = "6"
        case hit7 = "7"
        case hit8 = "8"
        case hit9 = "9"
        case hit10 = "10"
        case hit11 = "11"
        case hit12 = "12"
        case hit13 = "13"
        case hit14 = "14"
        case hit15 = "15"
        case hit16 = "16"
        case hit17 = "17"
        case hit18 = "18"
        case hit19 = "19"
        case hit20 = "20"
    }
}

// 商品情報格納クラス
class ItemData: Codable {
    // 商品名
    var name: String = ""
    // 商品URL
    var url: String = ""
    // 商品画像URL
    var imageInfo: ImageInfo = ImageInfo()
    // 価格
    var priceInfo: PriceInfo = PriceInfo()
    
    // 商品画像情報
    class ImageInfo: Codable {
        var medium: String?

        private enum CodingKeys: String, CodingKey {
            case medium = "Medium"
        }
    }
    
    // 価格情報
    class PriceInfo: Codable {
        var price: String?
        
        private enum CodingKeys: String, CodingKey {
            case price = "_value"
        }
    }
    
    // CodingKeyプロトコルを適用したCodingKeys列挙子
    private enum CodingKeys: String, CodingKey {
        case name = "Name"
        case url = "URL"
        case imageInfo = "Image"
        case priceInfo = "Price"
    }
}
